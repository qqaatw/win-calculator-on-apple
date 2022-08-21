#import "MSCalculatorWrapper.h"
#import "CalcManager/CalculatorManager.h"
#import "CalcManager/CalculatorResource.h"

class EngineResourceProvider : public CalculationManager::IResourceProvider
{
public:
    EngineResourceProvider();
    virtual std::wstring GetCEngineString(std::wstring_view id) override;
};

EngineResourceProvider::EngineResourceProvider(){
};

std::wstring EngineResourceProvider::GetCEngineString(std::wstring_view id)
{
    //LocalizationSettings^ localizationSettings = LocalizationSettings::GetInstance();

    if (id.compare(L"sDecimal") == 0)
    {
        return std::wstring(L".");
        //return localizationSettings->GetDecimalSeparatorStr();
    }

    if (id.compare(L"sThousand") == 0)
    {
        return std::wstring(L",");
        //return localizationSettings->GetNumberGroupingSeparatorStr();
    }

    if (id.compare(L"sGrouping") == 0)
    {
        // The following groupings are the onces that CalcEngine supports.
        //   0;0             0x000          - no grouping
        //   3;0             0x003          - group every 3 digits
        //   3;2;0           0x023          - group 1st 3 and then every 2 digits
        //   4;0             0x004          - group every 4 digits
        //   5;3;2;0         0x235          - group 5, then 3, then every 2
        
        return std::wstring(L",");
        
        //std::wstring numberGroupingString = localizationSettings->GetNumberGroupingStr();
        //return numberGroupingString;
        
    }

    //StringReference idRef(id.data(), id.length());
    //String ^ str = m_resLoader->GetString(idRef);
    return std::wstring(L",");//str->Begin();
}

// Copied from 3rdparty/calculator/src/CalculatorUnitTests/CalculatorManagerTest.cpp
class CalculatorManagerDisplayWrapper final : public ICalcDisplay
{
public:
    CalculatorManagerDisplayWrapper()
    {
        Reset();
    }

    void Reset()
    {
        m_isError = false;
        m_maxDigitsCalledCount = 0;
        m_binaryOperatorReceivedCallCount = 0;
    }

    void SetPrimaryDisplay(const std::wstring& text, bool isError) override
    {
        m_primaryDisplay = text;
        m_isError = isError;
    }
    void SetIsInError(bool isError) override
    {
        m_isError = isError;
    }
    void SetExpressionDisplay(
        _Inout_ std::shared_ptr<std::vector<std::pair<std::wstring, int>>> const& tokens,
        _Inout_ std::shared_ptr<std::vector<std::shared_ptr<IExpressionCommand>>> const& /*commands*/) override
    {
        m_expression.clear();

        for (const auto& currentPair : *tokens)
        {
            m_expression += currentPair.first;
        }
    }
    void SetMemorizedNumbers(const std::vector<std::wstring>& numbers) override
    {
        m_memorizedNumberStrings = numbers;
    }

    void SetParenthesisNumber(unsigned int parenthesisCount) override
    {
        m_parenDisplay = parenthesisCount;
    }

    void OnNoRightParenAdded() override
    {
        // This method is used to create a narrator announcement when a close parenthesis cannot be added because there are no open parentheses
    }

    const std::wstring& GetPrimaryDisplay() const
    {
        return m_primaryDisplay;
    }
    const std::wstring& GetExpression() const
    {
        return m_expression;
    }
    const std::vector<std::wstring>& GetMemorizedNumbers() const
    {
        return m_memorizedNumberStrings;
    }
    bool GetIsError() const
    {
        return m_isError;
    }

    void OnHistoryItemAdded(_In_ unsigned int /*addedItemIndex */) override
    {
    }

    void MaxDigitsReached() override
    {
        m_maxDigitsCalledCount++;
    }

    void InputChanged() override
    {
    }

    int GetMaxDigitsCalledCount()
    {
        return m_maxDigitsCalledCount;
    }

    void BinaryOperatorReceived() override
    {
        m_binaryOperatorReceivedCallCount++;
    }

    void MemoryItemChanged(unsigned int /*indexOfMemory*/) override
    {
    }

    int GetBinaryOperatorReceivedCallCount()
    {
        return m_binaryOperatorReceivedCallCount;
    }

private:
    std::wstring m_primaryDisplay;
    std::wstring m_expression;
    unsigned int m_parenDisplay;
    bool m_isError;
    std::vector<std::wstring> m_memorizedNumberStrings;
    int m_maxDigitsCalledCount;
    int m_binaryOperatorReceivedCallCount;
};

using namespace CalculationManager;

@interface CalculatorManagerWrapper ()
{
    std::shared_ptr<CalculationManager::CalculatorManager> manager;
    std::shared_ptr<CalculatorManagerDisplayWrapper> display;
    std::shared_ptr<EngineResourceProvider> provider;
}
@end

@implementation CalculatorManagerWrapper

-(id)init
{
    display = std::make_shared<CalculatorManagerDisplayWrapper>();
    provider = std::make_shared<EngineResourceProvider>();
    manager = std::make_shared<CalculatorManager>(
        display.get(),
        provider.get()
    );
    return self;
}

-(void)SetStandardMode
{
    manager->SetStandardMode();
}

-(void)SetScientificMode
{
    manager->SetScientificMode();
}

-(void)SetProgrammerMode
{
    manager->SetProgrammerMode();
}


-(NSString *)stringFromWchar:(const std::wstring)charText
{
    //used ARC
    return [[NSString alloc] initWithBytes:charText.data()
                                    length:charText.size() * sizeof(wchar_t)
                                  encoding:NSUTF32LittleEndianStringEncoding];
}

-(NSString *)GetPrimaryDisplay
{
    return [self stringFromWchar:display->GetPrimaryDisplay()];
}

-(NSString *)GetResultForRadix:(const uint)radix :(const int) precision :(const bool) groupDigitsPerRadix
{
    return [self stringFromWchar:manager->GetResultForRadix(radix, precision, groupDigitsPerRadix)];
}

-(void)ExecuteCommands:(const NSArray<NSNumber *>*)commands
{
    for (id command in commands)
    {
        manager->SendCommand((Command)[command intValue]);
    }
    
    if ((Command)[[commands lastObject] intValue] != Command::CommandNULL){
        manager->SendCommand(Command::CommandNULL);
    }
    
    manager->InputChanged();
}

-(void)SendCommand:(const NSNumber*) command
{
    manager->SendCommand((Command)[command intValue]);
    manager->InputChanged();
}

-(int)TestWithFirstValue:(int)a secondValue:(int)b
{
    CalculationManager::Command commands4[] = {
        CalculationManager::Command::Command2,
        CalculationManager::Command::CommandADD,
        CalculationManager::Command::Command3,
        CalculationManager::Command::CommandEQU,
        CalculationManager::Command::Command4,
        CalculationManager::Command::CommandEQU,
        CalculationManager::Command::CommandNULL,
    };
    
    Command* currentCommand = commands4;
    
    return a + b;
}

-(void)Reset:(bool)clearMemory
{
    manager->Reset(clearMemory);
}

@end

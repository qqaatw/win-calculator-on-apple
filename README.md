# Windows Calculator on Apple

<p align="center">
  <img src="assets/Calculator.png" style="height:300px"/>
</p>
<p align="center">
    A Windows calculator ported to macOS with SwiftUI interface.
</p>


Standard           |  Programmer
:-----------------:|:-------------------------:
![](assets/standard_mode.png)  |  ![](assets/programmer_mode.png)

# Build

Clone the project:

```bash
git clone --recursive https://github.com/qqaatw/win-calculator-on-apple.git
```

Install the prerequisite via Homebrew:

```bash
brew install cmake
# if you didn't select Xcode before, select the one you want to use.
sudo xcode-select -switch /Applications/Xcode.app
```

Build:

```bash
mkdir bulid && cd build
cmake .. -G Xcode  # generate Xcode project & configure compilers
cmake --build . --target Calculator  # build
```

The executable will be located in `build/Debug/Calculator.app`

# Development

TODO list:

1. UI improvement
1. Adding scientific mode
1. Unit testing
1. CI/CD
1. iOS support
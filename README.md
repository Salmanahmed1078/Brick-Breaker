# Setting Up the Irvine Library in Visual Studio

This guide will help you set up the Irvine library for Assembly programming using MASM in Visual Studio.

---

## Prerequisites

1. **Visual Studio** (Ensure you have the C++ desktop development workload installed.)
2. **MASM Assembler** (Included with Visual Studio.)
3. **Irvine Library** (Download from [kipirvine.com](http://kipirvine.com/)).

---

## Steps to Set Up Irvine Library

### 1. Download the Irvine Library

- Visit [kipirvine.com](http://kipirvine.com/) and download the Irvine library zip file.
- Extract the zip file to a directory, e.g., `C:\Irvine`.

---

### 2. Configure the Include and Library Paths

1. Open Visual Studio.
2. Go to **Tools** → **Options**.
3. Navigate to **Projects and Solutions** → **VC++ Directories**.
4. Select **Include Files** from the dropdown and add the path to the `\Irvine\Include` folder (e.g., `C:\Irvine\Include`).
5. Select **Library Files** from the dropdown and add the path to the `\Irvine\Lib` folder (e.g., `C:\Irvine\Lib`).

---

### 3. Create a New MASM Project

1. Open Visual Studio and create a new project.
2. Select **Empty Project** under **C++**.
3. Add a new file with the `.asm` extension (e.g., `main.asm`).

---

### 4. Configure the Project Properties

1. Right-click on your project in the Solution Explorer and select **Properties**.
2. Set the following:
   - **Configuration** → **General** → **Target Extension**: Set to `.exe`.
   - **Linker** → **General** → **Additional Library Directories**: Add the path to `C:\Irvine\Lib`.
   - **Linker** → **Input** → **Additional Dependencies**: Add `Irvine32.lib`.

---

### 5. Write and Compile Your Assembly Code

1. Add the following to your `.asm` file to include the Irvine library:
   ```asm
   INCLUDE Irvine32.inc
   .code
   main PROC
       ; Your code here
       exit
   main ENDP
   END main
   ```
2. Build your project and run it.

---

## Troubleshooting

1. **Error: Missing `Irvine32.lib`**
   - Ensure the library path is correctly added in the project properties.

2. **Error: Cannot find `Irvine32.inc`**
   - Verify the include path is correctly set.

3. **General Build Errors**
   - Make sure MASM is selected as the assembler in project properties.

---

## Additional Resources

- [Irvine Assembly Language Documentation](http://kipirvine.com/)
- [Visual Studio MASM Guide](https://learn.microsoft.com/en-us/cpp/assembler/masm/masm-for-x86-32-and-x64-visual-studio?view=msvc-latest)

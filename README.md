# 个人简历 / Resume

我的个人简历，基于 [matchy233/chi-cv-template](https://github.com/matchy233/chi-cv-template)
（`chicv`）改造而来，原模板扒自 [Alex Chi Zhang (skyzh)](https://github.com/skyzh)
的 [CV](https://skyzh.github.io/files/cv.pdf)。在此一并致谢。

📄 **成品：[resume.pdf](resume.pdf)**

## 环境要求

- 一个完整的 TeX 发行版（推荐 [MacTeX](https://www.tug.org/mactex/) / TeX Live），需带 **XeLaTeX**
- 字体已随仓库打包在 [`fonts/`](fonts/) 下，无需另外安装：
  - 标题字体：Avenir Next LT Pro
  - 中文字体：思源宋体（Source Han Serif CN，Regular / Medium / Bold / Heavy）

## 编译

本模板使用 XeLaTeX。因为用了 `hyperref` + 隐藏页码，需要跑两遍才能消除
“Rerun to get PageLabels” 提示。仓库已自带 [`.latexmkrc`](.latexmkrc)（已配好
XeLaTeX 引擎与默认源文件），直接一条命令即可：

```bash
latexmk          # 构建 resume.tex -> resume.pdf，自动重跑到稳定
latexmk -c       # 清理辅助文件，保留 PDF
```

也可以手动编译两遍：

```bash
xelatex resume.tex
xelatex resume.tex
```

> 字体路径在 `resume.cls` 里以相对路径 `./fonts/` 解析，请在**项目根目录**下编译
> （或覆盖 `\resumefontdir`）。

## 相比原模板做的改动

- 类文件重命名 `chicv.cls` → [`resume.cls`](resume.cls)，文档用 `\documentclass{resume}`
- 修正 macOS 上 `Avenir Next`（`.ttc`）被 fontspec 误判为存在却加载失败的问题，
  改为直接使用仓库内置的 `AvenirNextLTPro` 字体，开箱即可编译
- 完善中文支持：`\useChinese{<常规字重>}{<加粗字重>}` 一行开启思源宋体 + 中文断行，
  并补齐 CJK sans/mono 字体族，消除 xeCJK 警告
- `fontawesome5` 等可选宏包改为存在性检测加载，缺失时不致编译中断
- 显式加载 `fontspec`，字体目录抽成单一来源 `\resumefontdir`，五处引用统一管理
- 精简无用宏包（`xparse` 已入内核、`tabularx`/`calc` 未使用、XeLaTeX 下多余的
  `[T1]fontenc`），去掉重复的 `hyperref`
- 修正 `\linkedinsquare` 可选参数判断错误的 bug
- 新增 [`.latexmkrc`](.latexmkrc)，`latexmk` 一条命令完成构建

## 用法速览

文档结构见 [`resume.tex`](resume.tex)，常用自定义命令／环境：

- `\name{...}`、`basicinfo` 环境：姓名与基本信息
- `\section{...}`：分栏标题
- `\useChinese{Regular}{Bold}`：启用中文（也可换 `Medium`/`Heavy` 字重）

## License & 致谢

本仓库沿用原模板的 [MIT License](LICENSE)（© 2022 Matchy）。

- 模板作者：[Matchy (matchy233)](https://github.com/matchy233)
- 原始灵感与排版：[Alex Chi Zhang (skyzh)](https://github.com/skyzh)
- 代码大量参考了 [billryan/resume](https://github.com/billryan/resume)
  与 [ice1000/resume](https://github.com/ice1000/resume)

> 原作者注：迟先生本人已计划转向 [Typst](https://typst.app/)，感兴趣的同学也可以一试。

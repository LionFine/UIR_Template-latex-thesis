# Статус LaTeX-проекта

На 12 июня 2026 года:

- исходный кафедральный шаблон сохранен в `thesis-template/`;
- рабочая ПЗ находится в `thesis/`;
- `thesis/main.tex` подключает полный текст через `chapters/_content.tex`;
- главы, библиография, приложения и четыре схемы RAG подключены;
- сборка настроена через XeLaTeX, Biber и `latexmk`;
- результат создается в `thesis/build/main.pdf`;
- сборочные артефакты исключены из Git;
- исходный шаблон зафиксирован на commit `fdb501224fb2e7a7e4fc1c814182de732ed1688a`.

Команды проверки:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\check_latex_env.ps1
powershell -ExecutionPolicy Bypass -File .\scripts\build_thesis.ps1
```

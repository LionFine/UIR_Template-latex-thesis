# UIR Template: LaTeX thesis

Репозиторий содержит полный пример подготовки пояснительной записки к УИР:
исходный кафедральный шаблон и рабочую адаптацию для проекта `robyMAXrag`.

## Состав репозитория

| Путь | Назначение |
|---|---|
| `thesis-template/` | Неизмененная копия исходного кафедрального шаблона |
| `thesis/` | Рабочая пояснительная записка на основе шаблона |
| `thesis/main.tex` | Главная точка входа для сборки ПЗ |
| `thesis/chapters/_content.tex` | Порядок подключения глав, библиографии и приложений |
| `thesis/chapters/` | Данные титульного листа, главы и файл библиографии |
| `thesis/appendices/` | Приложения к пояснительной записке |
| `thesis/img/generated/` | Схемы RAG-пайплайна, используемые в тексте |
| `scripts/` | Проверка окружения и запуск сборки |
| `LATEX_PIPELINE.md` | Подробное описание процесса создания ПЗ |

Исходный шаблон получен из
[`skibcsit/thesis-template`](https://gitlab.com/skibcsit/thesis-template)
на commit `fdb501224fb2e7a7e4fc1c814182de732ed1688a` от 8 апреля 2026 года.
Вложенная папка `.git` намеренно не хранится: `thesis-template/` является
обычным каталогом текущего репозитория, поэтому все файлы шаблона доступны
после одного клонирования.

## Как устроена рабочая версия

1. `main.tex` загружает преамбулу из `chapters/thesis-template-macro.tex`.
2. Макросы читают сведения об авторе из `chapters/0-0-project-members.tex`
   и сведения о работе из `chapters/0-1-task-data.tex`.
3. Затем подключаются титульный лист и задание из `title/`.
4. `chapters/_content.tex` задает порядок глав, библиографии и приложений.
5. `latexmk` запускает XeLaTeX и Biber и складывает результат в
   `thesis/build/main.pdf`.

## Быстрый старт на Windows

Требуются MiKTeX или TeX Live, `latexmk`, Biber, Perl и системные шрифты
Times New Roman, Microsoft Sans Serif и Courier New.

Проверка окружения:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\check_latex_env.ps1
```

Сборка:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\build_thesis.ps1
```

Результат появится в `thesis/build/main.pdf`. Содержимое `build/` не
версионируется, потому что полностью воспроизводится из исходников.

Кроссплатформенный эквивалент:

```bash
cd thesis
latexmk -xelatex main.tex
```

## Где вносить изменения

- автор, группа и руководитель: `thesis/chapters/0-0-project-members.tex`;
- тема, сроки, этапы работы и литература задания:
  `thesis/chapters/0-1-task-data.tex`;
- порядок разделов: `thesis/chapters/_content.tex`;
- текст глав: отдельные файлы в `thesis/chapters/`;
- библиография: `thesis/chapters/biblio.bib`;
- приложения: `thesis/appendices/`;
- рисунки: `thesis/img/`, `thesis/figures/`;
- общие параметры оформления: `thesis/chapters/thesis-template-macro.tex`;
- параметры сборки: `thesis/latexmkrc`.

PDF-бланки, изображения, классы, стили и файлы подписей из исходного шаблона
сохранены без изменений.

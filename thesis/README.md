# Рабочая пояснительная записка

Это адаптация кафедрального шаблона для УИР по проекту `robyMAXrag`.

Основной поток сборки:

```text
main.tex
  -> chapters/thesis-template-macro.tex
  -> title/title-3-pz.tex
  -> title/task.tex
  -> chapters/_content.tex
  -> chapters/*.tex
  -> chapters/thesis-template-bibl.tex
  -> appendices/*.tex
```

Данные автора находятся в `chapters/0-0-project-members.tex`, данные задания
и работы - в `chapters/0-1-task-data.tex`. Порядок содержательных файлов
задается в `chapters/_content.tex`.

Сборка из корня репозитория:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\build_thesis.ps1
```

Либо из этого каталога:

```powershell
latexmk -xelatex main.tex
```

Итоговый файл: `build/main.pdf`.

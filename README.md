# README

Сервис трансформации изображений

## Системные требования
* Ruby 2.5.0+
* Rails 5.2.0+
* ImageMagick 6.9+

База данных не нужна

## Установка
```bash
git clone git@github.com:SteveRedka/image_transformer.git
cd image_transformer
bundle install
```

## Использование
На эндпоинт transform посылается файл и строка с параметрами типа `-resize 200x200`. Синтаксис тот же, что в imagemagick.

Пример:
```bash
curl -F 'transform[file]=@spec/fixtures/cats.png' -F 'transform[transformations]=-negate -resize 300x600!' http://localhost:3000/transform  --output output.png
```

## Комментарии
Поскольку в задаче не было указано, в каком виде следует передавать параметры, я сделал это самым простым способом.

Помимо этого, их можно было бы передавать не в виде слитной строки, а по отдельности:
```
# Это гипотетический, не рабочий код
curl -F 'transform[file]=@spec/fixtures/cats.png' -F 'transform[resize]=300x600!' -F transform[negate]=true http://localhost:3000/transform  --output output.png
```

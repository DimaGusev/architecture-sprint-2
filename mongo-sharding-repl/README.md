# pymongo-api

## Как запустить

Запускаем кластер mongodb с двумя шардами, по 3 реплики в каждом шарде, и приложение

```shell
docker compose up -d
```

Настраиваем шардирование, реплицирование и наполняем данными:

```shell
./scripts/setup.sh
```

## Как проверить

### Если вы запускаете проект на локальной машине

Откройте в браузере http://localhost:8080

### Проверить число документов в базе данных

```shell
./scripts/count.sh
```
# Схема с архитектурой приложения
Находиться с репозитории schema/dgusev_sprint2.drawio
Также доступна по [ссылке](https://drive.google.com/file/d/1C1QJjJnjuSykIG2b3vg_pnpRjEwmk6h6/view?usp=sharing)

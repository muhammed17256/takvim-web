# Takvim Web 📅🐳

Çok sayfalı, saf HTML/CSS/JS takvim uygulaması. nginx ile Docker image'ına paketlenir ve Docker Hub'a **versiyonlu** yüklenir.

- Docker Hub: https://hub.docker.com/r/KULLANICI_ADI/takvim-web
- GitHub: https://github.com/GITHUB_KULLANICI_ADI/takvim-web

## Sayfalar
| Adres | İçerik |
|-------|--------|
| `/index.html` | Aylık takvim, güne tıklayıp etkinlik ekleme/silme (saat, renk) |
| `/etkinlikler.html` | Tüm etkinlikler: arama, filtre, JSON/ICS indirme, JSON içe aktarma |
| `/tatiller.html` | Yıla göre resmi tatiller, kalan gün, dini bayramlar |
| `/hakkinda.html` | Çalışan image versiyonu, build tarihi, Docker komutları |
| `/healthz` | Sağlık kontrolü (`ok` döner) |
| `/version.json` | Image versiyonu ve build tarihi |
| `/404.html` | Özel hata sayfası |

Etkinlikler tarayıcının localStorage alanında tutulur, sunucuya veri gönderilmez.

## Proje yapısı
```
takvim-web/
├── site/
│   ├── index.html, etkinlikler.html, tatiller.html, hakkinda.html, 404.html
│   ├── css/style.css
│   └── js/common.js
├── nginx.conf
├── Dockerfile
├── docker-compose.yml
├── scripts/release.ps1, release.sh
├── .github/workflows/docker-publish.yml
├── screenshots/
├── CHANGELOG.md
└── LICENSE
```

## Versiyonlama nasıl çalışıyor?
Dockerfile `APP_VERSION` build argümanını alır. Build sırasında sayfalardaki `__APP_VERSION__` yazısı bu değerle değiştirilir ve `version.json` üretilir. Böylece image'ı çalıştırınca hangi sürüm olduğu sayfanın altında ve `/version.json` içinde görünür.

## Build ve çalıştırma
```bash
docker build -t KULLANICI_ADI/takvim-web:v1.0 --build-arg APP_VERSION=v1.0 .
docker run -d -p 8080:80 --name takvim KULLANICI_ADI/takvim-web:v1.0
```
Tarayıcıda http://localhost:8080 adresini aç. Durdurmak için `docker rm -f takvim`.

## Docker Hub'a yükleme (Push)
```bash
docker login
docker push KULLANICI_ADI/takvim-web:v1.0
```
Tek komutla (v2.0 örneği, Windows PowerShell):
```powershell
.\scripts\release.ps1 -User KULLANICI_ADI -Version v2.0
```
Linux/Mac: `./scripts/release.sh KULLANICI_ADI v2.0`

## Çekme (Pull)
```bash
docker pull KULLANICI_ADI/takvim-web:v1.0
docker pull KULLANICI_ADI/takvim-web:v2.0
docker run -d -p 8080:80 KULLANICI_ADI/takvim-web:v2.0
```

## Versiyonlar
| Tag | Açıklama |
|-----|----------|
| v1.0 | İlk sürüm |
| v2.0 | Çok sayfalı sürüm |
| latest | En son sürüm |

Ayrıntılar için `CHANGELOG.md`.

## Docker Compose
```bash
TAG=v2.0 DOCKERHUB_USER=KULLANICI_ADI docker compose up -d
```

## Otomatik yayın (GitHub Actions)
1. Docker Hub → Account Settings → Security → New Access Token
2. GitHub → Settings → Secrets and variables → Actions → `DOCKERHUB_USERNAME`, `DOCKERHUB_TOKEN`
3. `git tag v2.0 && git push origin v2.0` → image otomatik build edilip yüklenir.

## Sorun giderme
| Sorun | Çözüm |
|-------|-------|
| `open Dockerfile: no such file` | Yanlış klasördesin, `cd takvim-web` ve `dir` ile kontrol et |
| `Dockerfile.txt` görünüyor | `ren Dockerfile.txt Dockerfile` |
| 8080 portu dolu | `-p 8081:80` ile başka port kullan |
| Container adı zaten var | `docker rm -f takvim` |
| Push `denied` hatası | `docker login` yap, image adı Docker Hub kullanıcı adınla başlamalı |

## Ekran görüntüleri
`screenshots/` klasörüne Docker Hub Tags sayfası, pull çıktısı ve sayfa görüntüleri eklenir.

## Lisans
MIT, bkz. `LICENSE`.
# takvim-web

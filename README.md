# KPGC Ventures Pvt. Ltd. Website (Flutter Web)

Premium real estate website for KPGC Ventures, featuring Royal Woods.
Built with Flutter, Dart, Material 3, go_router, google_fonts, flutter_animate, url_launcher and video_player.

## Run it
```bash
# 1. Unzip, then inside this folder generate the platform files (keeps your lib/, assets/, web/index.html)
flutter create . --platforms=web --project-name kpgc_ventures_website
flutter pub get
flutter analyze
flutter run -d chrome
```
If `flutter create` replaced `web/index.html`, copy the meta tags from this README's project (title, description, canonical, og:*) back in.

## Build and deploy
```bash
flutter build web --release
```
Upload `build/web` to any host. All routes must fall back to `index.html`:
- Firebase Hosting: `firebase.json` is included (`firebase deploy --only hosting`).
- Netlify: `web/_redirects` is included.
- Vercel / others: add a rewrite of `/*` to `/index.html`.

## Before launch (replace placeholders)
1. `lib/config/site_config.dart`: confirm official email, set production domain (`siteUrl`).
2. `web/index.html`, `web/robots.txt`, `web/sitemap.xml`: replace `https://www.your-domain.com`.
3. `assets/images/`: replace the three render crops with original high-resolution files (same names, or edit `lib/config/image_config.dart`). Replace `assets/video/royal_woods_construction.mp4` with the full-quality video.
4. Replace the text logo in `lib/core/widgets/kpgc_logo.dart` with the official logo file.
5. Verify with KPGC, then fill in `lib/data/mock/project_data.dart`: configurations, MahaRERA number, possession date, amenities, specifications. Until then the site shows "Contact us for current details". Also confirm Royal Woods' status and the services list (`service_data.dart`).
6. The About page, Privacy Policy and Terms contain draft wording. Have them reviewed. Add a leadership section only with real names, bios and approved photos.
7. Add real photographs to the gallery (`gallery_page.dart`). Do not label renders or stock images as construction progress.

## Enquiry forms (important)
No backend is configured. "Send Enquiry via WhatsApp" opens WhatsApp with the details pre-filled, and the site says so. Nothing is stored and success is never faked.
To store enquiries, replace `_submit` in `lib/core/widgets/enquiry_form.dart` with a call to your own backend or Firebase (Firestore with secure rules, written by a server or Cloud Function). Never put admin or service-account keys in client code. Only show success after the request really succeeds.

## SEO notes
Flutter Web is rendered on a canvas, so search engines see the `web/index.html` shell rather than page text. Keep key metadata there, and consider a static landing/SEO page or pre-rendering service for production. Rankings cannot be guaranteed.

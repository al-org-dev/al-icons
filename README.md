# al-icons

`al_icons` owns icon runtime assets for `al-folio` v1.x.

## Responsibilities

- Render icon stylesheet tags via `{% al_icons_styles %}`
- Centralize pinned icon CDN URLs and optional SRI usage
- Keep icon ownership out of `al_folio_core` and starter runtime files

## Installation

```ruby
gem 'al_icons'
```

```yaml
plugins:
  - al_icons
```

Render in head templates:

```liquid
{% include plugins/al_icons_styles.liquid %}
```

## Expected config

```yaml
third_party_libraries:
  fontawesome:
    url:
      css: https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@7.2.0/css/all.min.css
    integrity:
      css: ...
  academicons:
    url:
      css: https://cdn.jsdelivr.net/npm/academicons@1.9.5/css/academicons.min.css
    integrity:
      css: ...
  scholar-icons:
    url:
      css: https://cdn.jsdelivr.net/npm/scholar-icons@1.0.3/css/scholar-icons.css
    integrity:
      css: ...
```

`integrity.css` is optional per library.

## Contributing

Icon provider/CDN ownership changes should be proposed in this repository.

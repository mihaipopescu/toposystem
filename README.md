# Creative Theme for Jekyll

A Jekyll implementation of the [Creative Theme](http://startbootstrap.com/template-overviews/creative/) template by [Start Bootstrap](http://startbootstrap.com).

Creative is a one page Bootstrap theme for creatives, small businesses, and other multipurpose uses.
The theme includes a number of rich features and plugins that you can use as a great boilerplate for your next Jekyll project! 

See it live in action at <https://volny.github.io/creative-theme-jekyll/>

## To use the Creative Theme template in your project

- Start by adding your info in `_config.yml`
- In `_layouts/front.html` reorder or remove section as you prefer.

### Migrating old proiecte.html data

The legacy site includes a `proiecte.html` table with a “Suprafata”
column (hectares) and execution date.  Use the helper script to convert
it into Jekyll data with numeric `area_num` and parsed `year`:

```bash
# install dependency
gem install nokogiri

ruby scripts/extract_projects.rb path/to/proiecte.html > _data/projects.yml
```

The output YAML ends up in `_data/projects.yml` and is used by the
visualisations below.  Re-run the script whenever you update the source
HTML or want to tweak entries.

### Front-page chart

Instead of a separate projects page, a mixed chart is rendered directly on
the home page in place of the old portfolio section.  Each year's total
area is shown as a bar, and a red line (with its own right-hand axis)
indicates the number of projects that year. The individual-point layer
has been removed to reduce clutter.  Hovering a bar displays the total
area.  The code lives in `_includes/portfolio.html` and uses Chart.js with
the `date-fns` adapter; it consumes `site.data.projects`.

### Static image (optional)

To produce a pre-rendered graphic, run `ruby scripts/generate_timeline_image.rb`.
It hits [QuickChart.io](https://quickchart.io) and writes `img/timeline.png`.
Include that file in your layout if you need an image version.

(The rest of the README remains as originally provided.)


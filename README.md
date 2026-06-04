# OBIS project badges

Badges for use in the OBIS GitHub repositories or projects.

Badges are created using [Shields.io](https://shields.io/). You can use them on any README repository by linking to the raw images on the badges folder.

For example, to use the `OBIS - Products catalogue` badge, you would first get the raw address of the badge:

`https://raw.githubusercontent.com/iobis/badges/refs/heads/main/badges/obis-products_catalogue.svg`

Which is basically:

`https://raw.githubusercontent.com/iobis/badges/refs/heads/main/badges/` + **the badge file name**

Being the badge file name always:

`right-side-text` + `-` + `left-side-name with spaces converted to underscore`

Then you can use it on GitHub by adding:

`[![]({the url})]({link})`

Or if you don't intend to have a link, simply:

`![]({the url})`

For example, you can link to a product on the OBIS catalogue by using the following:

`[![](https://raw.githubusercontent.com/iobis/badges/refs/heads/main/badges/obis-products_catalogue.svg)](https://products.obis.org/dataset/10-5281-zenodo-19392660)`

## Development

Badges are created by specifying the attributes on [`badges-specs.yml`](badges-specs.yml). Logos should be base64 encoded and added to [`base-64-logos.json`](base-64-logos.json). Make sure the name and type of the logo on the YAML file matches those in the JSON file.

To generate the files run `generate-badges.R`:

``` bash
Rscript generate-badges.R
```

Dependencies will be checked and installed.
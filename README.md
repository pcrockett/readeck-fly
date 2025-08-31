# readeck-fly

Get [Readeck](https://readeck.org/en/) running on [Fly.io](https://fly.io/) for dirt
cheap (or free).

## getting started

```bash
make launch
```

## custom domain (optional)

You are certainly welcome to use your default `app-name.fly.dev` if you want, however
if you want your app to run behind your own custom domain, you can check out [Fly's
official docs on how to do that](https://fly.io/docs/networking/custom-domain/).

What I personally do:

1. Set up a CNAME that points to your `app-name.fly.dev` domain
2. Run `flyctl certs add your-custom-domain.example.com`

... and that's it. You're up and running.

## content scripts

I have my own content scripts here too. [Example.](./content-scripts/github-readme.js)
If you want to use them on your server, you can upload them via:

```bash
make content-scripts
```

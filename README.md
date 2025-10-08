# janet-grapple-trial-kit

The main purpose of this trial kit is to make it easy to get a taste
of Janet with [Grapple / mREPL](https://github.com/pyrmont/grapple)
without having to change your existing editor [1] configuration.

![Demo](janet-grapple-trial-kit-linux.png?raw=true "Demo")

[1] Currently, that's Neovim using
[Conjure](https://github.com/Olical/conjure).

## Requirements

* [git](https://git-scm.com/)
* [janet](https://janet-lang.org)
* [neovim](https://neovim.io) - recent version might be necessary (>= 0.11.0?)

For Windows:

* Only tested with neovim installed via scoop, YMMV.
* Probably you want to investigate your ["Credential Helper
  Selector"](https://kevinfiol.com/blog/getting-rid-of-the-credential-helper-selector-on-git-for-windows/)
  situation before trying this on Windows.

## What You Get

The trial kit include the following bits.

### Janet-Specific

* mREPL interaction via [Conjure](https://github.com/Olical/conjure/) and
  [Grapple](https://github.com/pyrmont/grapple)
* Basic Janet code handling (e.g. indentation) via
  [janet.vim](https://github.com/janet-lang/janet.vim)

### Extras

* Dark theme via [gruvbox](https://github.com/morhetz/gruvbox)
* Simple plugin manager via [vim-plug](https://github.com/junegunn/vim-plug)

## Initial Setup

Initial invocations:

```
git clone https://github.com/sogaiu/janet-grapple-trial-kit
cd janet-grapple-trial-kit
janet jgtk
```

The above lines may take some time to complete as there will likely
be multiple git cloning operations.

The end result should be a started up Neovim.

## Verifying Things Are Working

### Basic Evaluation

Open the `sample.janet` file, e.g. via `:e sample.janet`.  Once
opened, one should see:

```janet
(+ 1 2)

(import ./sample-lib :as sl)

(defn my-fn
  [x]
  (+ x (sl/lib-fun -1)))

(my-fn 3)
```

Also visible should be Conjure's
[HUD](https://en.wikipedia.org/wiki/Head-up_display) indicating a
successful connection.  A message somewhat like the following should
be visible:

```
# Sponsored by @chad
======= info =======
Connected to Grapple v1.0.0-dev running Janet v1.40.0 as session 11
```

A `janet` process (`grapple`) should be running, listening at
`127.0.0.1` on TCP port `3737`.

To evaluate some code, move the cursor somewhere on top of
`(+ 1 2)` and enter `,er`.  The result should be something like
the following in the HUD:

```
====== input =======
(+ 1 2)
====== result ======
3
```

Moving the cursor should cause the HUD disappear.

If you want to see a log buffer instead of a HUD, try `,lv`.

### Redefinition in Another File

To see redefinition in another file having an appropriate effect, try
the following steps.

#### Evaluate a Call to `my-fn`

Arrange to observe a call to `my-fn` by successively evaluating the
following code already present in the buffer:

* `(import ./sample-lib :as sl)`
* `(defn my-fn ...)`
* `(my-fn 3)`

Navigate the cursor on to each bit of code and use `,er` in turn.

The call to `my-fn` should yield the result `10`.

#### Redefine `lib-fun` in Another File

Open `sample-lib.janet`, e.g. by `:e sample-lib.janet`.  The following
code should appear:

```janet
(defn lib-fun
  [x]
  (+ x 8))
```

Change `8` to be some other number, e.g. `11`:

```janet
(defn lib-fun
  [x]
  (+ x 11))
```

Evaluate the definition of `lib-fun` using `,er`.

#### Call `my-fn` Again in Original File

Open `sample.janet` again, e.g. by `:e sample.janet`.

Evaluate `(my-fn 3)` via `,er`.

The call to `my-fn` should result in `13` (if `8` was changed to `11`
earlier).

### Stopping `grapple`

Quitting neovim will NOT automatically stop the `janet` process
running `grapple` which is listening on a TCP port.

The process can be stopped manually or from within neovim by either
of:

* `,cS` -OR-
* `:ConjureJanetStop`

N.B. The above "within neovim" methods will not work for a `grapple`
server that was started manually or one that was started in an earlier
neovim session.

It's probably better to stop the `grapple` process if it isn't going
to be used.

### Getting Help about Conjure

Check out `:ConjureSchool` to learn more.

## Typical Use

Start Neovim by:

```
janet jgtk
```

To specify a file to edit (e.g. `sample.janet`) on startup:

```
janet jgtk sample.janet
```

## Operating Systems with Confirmed Success

* Android via Termux (`janet` built from source)
* Linux Mint
* Windows 11

## Cleanup

* Removing the cloned directory should remove nearly all traces of
  this program because everything except `$XDG_RUNTIME_DIR` lives
  within the cloned directory.  IIUC, the content of the exception
  (`stdpath("run")`) lives in a temporary directory anyway so it may be
  that one's system will clean it up automatically.

* If you just want a "fresh start", this can be done by issuing `git
  clean -ff .` from the cloned directory. This should remove all
  (non-temporary) files and directories that got added via `janet
  jgtk`.  Alternatively, just remove the cloned directory and
  reclone to start over.

## Caveats

Various `XDG_*` environment variables are set before starting `nvim`
to influence what is returned by `stdpath`.

## Credits

Thanks to authors of various bits, but also the following folks for
efforts specifically regarding this project:

* amano-kenji
* bakpakin
* Grazfather
* harryvederci
* Olical
* pyrmont


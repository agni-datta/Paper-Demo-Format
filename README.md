<!-- @format -->

# Paper Template for Cryptography and Theory Conferences

A single-source LaTeX template that compiles as both a **full article / eprint**
and an **LLNCS conference submission** by flipping three flags at the top of
`main.tex`. No separate files, no manual copy-paste.

## Quick start

```bash
make pdf      # full article / eprint (default)
make llncs    # Springer LLNCS submission
make all      # both at once
make clean    # remove build artifacts
make distclean # also remove output PDFs
```

Both targets read the same `main.tex`. The `llncs` target uses `sed` to flip
`\Submissionfalse` → `\Submissiontrue` on the fly and feeds the result into
`latexmk` — no second `.tex` file is needed.

## Compilation flags

Edit exactly these three lines near the top of `main.tex`:

```latex
\Submissionfalse   % \Submissiontrue  → LLNCS / conference submission
\Eprinttrue        % \Eprintfalse     → suppress "Full Version" title suffix
\Commentsfalse     % \Commentstrue    → enable author margin notes
```

| Flag            | `true`                                          | `false`                            |
| --------------- | ----------------------------------------------- | ---------------------------------- |
| `\ifSubmission` | LLNCS class + llncscrypto packages              | article class + csamsmath packages |
| `\ifEprint`     | Adds "(Full Version)" to title, 1.10 linespread | Standard title, no extra spread    |
| `\ifComments`   | Author margin notes active                      | Notes silently suppressed          |

## Repository layout

```
Paper-Demo-Format/
├── main.tex            ← single source of truth (class, packages, document)
├── macros.tex          ← paper-specific math macros (input'd by main.tex)
├── bib/
│   └── bibliography.bib    ← your references; see header for CryptoBib setup
├── Makefile
├── .latexmkrc          ← pdflatex + synctex + shell-escape
├── .gitignore
├── csamsmath.sty       ← article/eprint math backbone
├── llncscrypto.sty     ← LLNCS crypto/theorem layer
└── tcscrypto.sty       ← shared TCS/crypto notation (loaded by both)
```

## Style files

All three `.sty` files live in the repo root so collaborators need nothing
installed beyond a standard TeX Live / MiKTeX distribution.

### `tcscrypto.sty` ← **start here for notation**

Comprehensive TCS and cryptography macro suite shared by both compilation
modes. It defines virtually every macro you need for a crypto/TCS paper;
**add paper-specific overrides in `macros.tex` only after checking this file.**

Key namespaces provided:

| Category               | Examples                                                                                                                                                                  |
| ---------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Security parameter     | `\secparam`, `\SecParam`, `\comparam`                                                                                                                                     |
| Sampling               | `\getsr`, `\longsample`                                                                                                                                                   |
| Math operators         | `\Pr`, `\E`, `\poly`, `\polylog`, `\negl`, `\log`, `\lg`                                                                                                                  |
| Delimiters             | `\abs{}`, `\floor{}`, `\ceil{}`, `\norm{}`, `\inner{}{}`, `\set{}`, `\tuple{}`                                                                                            |
| Number sets            | `\NN`, `\ZZ`, `\QQ`, `\RR`, `\FF`, `\GG`, `\CC`                                                                                                                           |
| Short math fonts       | `\bbX`, `\calX`, `\sfX`, `\scrX`, `\frakX` (A–Z for each)                                                                                                                 |
| Crypto schemes         | `\PRF`, `\PRG`, `\OWF`, `\PKE`, `\SKE`, `\SIG`, `\NIZK`, `\SNARG`, `\SNARK`, `\IOP`, `\MPC`, `\FHE`, `\IBE`, `\ABE`, `\KEM`, `\VC`, `\PC`, `\CM`, `\ZK`, `\ROM`, … (100+) |
| Scheme methods         | `\PRFEval`, `\PKEEnc`, `\PKEDec`, `\SIGSign`, `\SIGVerify`, `\SNARGProve`, …                                                                                              |
| Adversaries            | `\Adv`, `\advA`, `\advB`, `\advC`, `\advD`, `\advZ`, `\Red`                                                                                                               |
| Proof entities         | `\Prover`, `\Verifier`, `\MaliciousProver`, `\MaliciousVerifier`, `\HonestProver`                                                                                         |
| Security notions       | `\indcpa`, `\indcca`, `\eufcma`, `\sufcma`, `\INDCPA`, `\INDCCA`, `\EUFCMA`, …                                                                                            |
| Security games         | `\advantage{notion}{scheme}`, `\newsequenceofgames{}`, `\nextgame{}`, `\gameref{}`, `\gamedelta{}{}`                                                                      |
| Oracles                | `\HashOracle`, `\SignOracle`, `\CDHOracle`, `\DDHOracle`, `\SendOracle`, …                                                                                                |
| Computational problems | `\LWEProb`, `\SISProb`, `\CDHProb`, `\DDHProb`, `\RSAProb`, `\SATProb`, `\SVPProb`, … (60+)                                                                               |
| Hardness assumptions   | `\LWE`, `\SIS`, `\CDH`, `\DDH`, `\RSA`, `\RLWE`, `\MLWE`, …                                                                                                               |
| Complexity classes     | `\NP`, `\BPP`, `\PP`, `\PSPACE`, `\CLS`, `\EOL`, `\PWPP`, `\TFNP`, …                                                                                                      |
| Cryptographic worlds   | `\Minicrypt`, `\Cryptomania`, `\Obfustopia`, `\Pessiland`, …                                                                                                              |
| Pseudocode keywords    | `\pcif`, `\pcelse`, `\pcfor`, `\pcwhile`, `\pcreturn`, `\pclet`, `\pcabort`, …                                                                                            |
| Protocol environment   | `\begin{protocolbox}[Title] … \end{protocolbox}`                                                                                                                          |
| Lattice notation       | `\latbasis`, `\latvec{}`, `\laterror`, `\latpubmat`, `\latsecret`, `\lattrap`                                                                                             |
| Pairing groups         | `\GGone`, `\GGtwo`, `\GGt`, `\GT`, `\pairing{}{}`                                                                                                                         |
| Kolmogorov complexity  | `\Kt`, `\KS`, `\KC`, `\pKt`, `\rKS`                                                                                                                                       |
| Proof complexity       | `\Axioms`, `\Clauses`, `\proves`, `\Tseitin`, `\Restrict{}{}`                                                                                                             |
| Abbreviations          | `\eg`, `\ie`, `\cf`, `\wrt`, `\etal`, `\vs`, `\nb`                                                                                                                        |
| Distributions          | `\cindist`, `\sindist`, `\pindist`, `\StatDist`, `\Uniform{}`                                                                                                             |

To define a new block of scheme algorithms in one shot:

```latex
\cryptoDefineAlgoCSV{KeyGen/KeyGen, Enc/Enc, Dec/Dec}
\cryptoDefineSchemeCSV{MyScheme/MS}
\cryptoDefineOracleCSV{Challenge/Chal}
```

### `csamsmath.sty` (article / eprint mode)

Mathematical backbone for the full-version article. Loads and configures:

```[latex]
amsmath,
amssymb,
amsthm,
booktabs,
caption,
cleveref,
comment,
enumitem,
etoolbox,
graphicx,
hyperref,
makecell,
mathrsfs,
mathtools,
mdframed,
microtype,
multirow,
paralist,
setspace,
tabularray,
tabularx,
thmtools,
tocbibind,
xcolor,
xparse,
xspace,
```

**Font options** (pass as package option):
`latinmodern` (default), `libertine`, `palatino`, `concrete`, `gfsdidot`, `baskervaldx`

**Mode options**: `draft` (enables margin notes), `final` (default, suppresses all annotations)

**Theorem environments** (all numbered per-section):
`theorem`, `lemma`, `corollary`, `proposition`, `conjecture`, `fact`, `claim`,
`definition`, `notation`, `protocol`, `construction`, `remark`, `note`,
`example`, `observation`, `openproblem`

### `llncscrypto.sty` (LLNCS / submission mode)

Bridges `llncs.cls` with the crypto macro stack. Used only when
`\Submissiontrue`. Must be loaded after `\documentclass{llncs}`.

**Feature options**: `crypto` (loads tcscrypto), `theorems` (standardized LLNCS
theorem wrappers), `tikz` (PGF/TikZ with crypto libraries), `captions`,
`libertine`, `appendix`

**Mode options**: `preprint` (custom 11pt eprint layout), `draft`, `final`

## Writing your paper

### Adding macros

Open `macros.tex`. The comment block at the top lists everything
`tcscrypto.sty` already provides — check there before defining anything new.
Add only paper-specific commands below the divider line.

### Bibliography

The template uses a minimal `bib/bibliography.bib` for paper-specific entries.
For standard cryptography and TCS references, download the community databases:

```

CryptoBib https://cryptobib.di.ens.fr/
→ bib/abbrev0.bib (or abbrev1/2/3 for varying abbreviation length)
→ bib/crypto.bib

CSTheoryBib https://github.com/DeviousCilantro/cstheorybib
→ bib/cstheory.bib

```

Then update the `\bibliography` line in `main.tex`:

```latex
\bibliography{bib/abbrev0, bib/crypto, bib/cstheory, bib/bibliography}
```

Bibliography style is set automatically: `splncs04` for LLNCS, `alphaurl` for
article.

### Author notes (comments mode)

Set `\Commentstrue` in `main.tex`, then add per-author macros in the comments
block:

```latex
\newcomment{Alice}{RoyalBlue}{alice}   % gives \alice{note text}
\newcomment{Bob}{Firebrick4}{bob}      % gives \bob{note text}
```

Use `\missing{text}` for content placeholders (shown in red with a star in the
margin; rendered normally in non-comments mode).

## Requirements

- TeX Live 2022 or later (or MiKTeX equivalent)
- `latexmk`, `pdflatex`, `sed` (all standard on Linux/macOS)
- No additional package installation — all `.sty` files are bundled

## License

Style files (`csamsmath.sty`, `llncscrypto.sty`, `tcscrypto.sty`) are
distributed under the **LaTeX Project Public License v1.3c**.
Template files (`main.tex`, `macros.tex`, `Makefile`, etc.) are provided as-is
for unrestricted use.

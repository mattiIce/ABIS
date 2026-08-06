# The 6x10 label — Novelis variant, and the Certificate of Conformance

Recorded from photographs of **real production output**, 2026-08-06, alongside the legacy source and
the live `.230` tables. This is the reference for reworking `ShippingLabel6x10`, which currently
implements a **different variant**.

> **The label format is a PER-CUSTOMER requirement** (confirmed by the plant). Novelis uses the layout
> below; the variant already implemented uses different field numbering. Neither is "the" format.

---

## 1. The two variants, and how they differ

The DataWindow carries both under the **same control names**, distinguished only by the caption text of
`t_9`. That is why they collided during the first port — see `ShippingLabel6x10`'s remarks.

| field | **gross variant** (implemented) | **theo variant** (Novelis, photographed) |
|---|---|---|
| 6 | `6-ACTUAL WT.` | `6-ACTUAL WT.` **(2Q)** |
| 7 | `7-GROSS WT` | **`7-LGTH./THEO.WT` (1Q)** |
| 7/9 | `7-SIZE` (one line, inches) | **`9-SIZE`** — three lines, **mm** |
| 8 | `8-PIECES` | `8-PIECES` **(Q)** |
| 9/10 | `9-ALLOY` | **`10-ALLOY`** — `5182 - O4` |
| 10/11 | `10-DLOC:` | **`11-LOT NO.` — a multi-coil TABLE** |

## 2. What the Novelis label shows that the current port does not

1. **The AIAG identifier prints as a caption** beneath each field number: `(P)`, `(V)`, `(S)`, `(A)`,
   `(1T)`, `(2Q)`, `(1Q)`, `(Q)`. This is `is_N_t.Text = "(" + is_N + ")"` in
   `u_default_barcode.sru`. The port currently puts the identifier only in the barcode DATA.
2. **The human-readable value sits ABOVE the barcode, with NO interpretation line below it.** The port
   emits `^B3 …,Y,N`, which prints the text underneath. It should be `N` for this variant, with the
   value drawn as its own text field above.
3. **Units are kg and metric mm.** Matches the 2021 constructor change in `u_default_barcode.sru`
   (`ib_act_kg` and `ib_size_metric` both flipped FALSE→True,
   "1159_Change_Checkmarks_On_Barcode_Printing_Screen"). Observed: `1935 kg`, `1.3 X 1727.2 X 1470.`
4. **Size prints on three lines**, not one — gauge / width / length stacked, each followed by `X`
   except the last.
5. **`11-LOT NO.` is a table** with columns `LOT NO. / SMELT / COIL NO. / PCES / H.T. DATE` and
   numbered rows `1. 2. 3.`. Observed row 1: `5897540 | CA AE | 1957838 | 250 | 07/23/2026`.
   This is what "barcode from **contains multiple items**" means in the DataWindow's own comment.
6. **A customer address footer**: `NOVELIS ALUMINUM CORPORATION-OSWEGO,  OSWEGO,  NY 13126`
7. **The footer carries an extra field** between `SK#` and the date — observed `3000032609`
   (unidentified; likely the package number, cf. `uf_set_package_num` in the legacy source).
8. **Empty fields print their caption and nothing else** — `2-SUPPLIER NO. (V)` and
   `7-LGTH./THEO.WT (1Q)` were both blank on the sample, with **no barcode drawn**. The port already
   omits a barcode for an empty value, which matches.
9. **The label is fully ruled** — horizontal rules between every numbered field, verticals dividing
   the lower block. The `line()` elements are recovered in `LABEL_6X10_LAYOUT.md`.

## 3. The Certificate of Conformance

Printed **on the same 6x10 stock, inline with the shipping labels** — one cert per skid where the
shipping label prints twice. Not a separate printer or stock.

Gated by `f_coil_cert_label_req(shipment)`, and legacy **abandons the entire print run** if
`f_all_coils_have_863(shipment)` fails: a skid whose coils have no test data cannot be certified.
**The port has no such gate.**

```
                Certificate of Conformance
            Novelis Corporation - Atlanta, GA 30326

        Ship to:  WAYNE IND
                  36253 MICHIGAN AVE
                  WAYNE, MI, 48135

                  Skid #: T1846071

Coil:        1957838          Size (mm):  1.30 X 1727.20 X 1470.00
ABC Serial:  235552           Born Date:  07/23/2026
Part:        68416649-1
Spec:        MS.50005  MS.50005-AA5000-RS-U
Cntry of Cast: CA
Primary Cntry of Smelt  CA        Secondary Cntry of Smelt  AE

Chemical Composition
  SI 0.06   FE 0.21   CU 0     MN 0.34
  MG 4.57   CR 0.03   ZN 0     TI 0.01
  V  0      AL 94.78

Mechanical Properties
  Tensile (MPA)      283 mpa    R Value                 0.8
  Yield (MPA)        127 mpa    PT Bot Center           2.4 mg/m2
  Elongation UNI(%)   24 %      PT Top Center           2.2 mg/m2
  Elongation TOT(%)   25 %      PT Rinse Loss Bot Cen     3 %
  N Value 10-UTS     0.27       PT Rinse Loss Top Cen     4 %
  Thickness        1.295 mm
```

### The mechanical properties are table-driven — confirmed

Every property above is a row of `CERT_LABEL_DATA_ELEMENTS` for `customer_id=1153, customer_code=1`
(FCA), **in that table's `seq_num` order**:

| seq | element | description | on the cert |
|---:|---|---|---|
| 1 | `ttl` | Tensile (MPA) | yes |
| 2 | `trt` | R Value | yes |
| 3 | `ttt` | Yield (MPA) | yes |
| 4 | `mdo` | PT Bot Center | yes |
| 5 | `ult` | Elongation UNI(%) | yes |
| 6 | `dpa` | PT Top Center | yes |
| 7 | `tet` | Elongation TOT(%) | yes |
| 8 | `aro` | PT Rinse Loss Bot Cen | yes |
| 9 | `x27` | N Value 10-UTS | yes |
| 10 | `bkn` | PT Rinse Loss Top Cen | yes |
| 11 | `n4t` | N Value 4-6 | — |
| 12 | `itt` | Thickness | yes |
| 13 | `tnt` | N-Value Transverse | — |
| 14 | `ysr` | Raw Yield (MPA) | — |

The three absent ones presumably had no value for this coil. **So the cert's mechanical block is
generated from that table, not laid out statically** — and GM (`customer_code=2`) has a different,
shorter list, so the block must be built per (customer, OEM).

### Data sources

- **Mechanical properties** → `PST_TEST_RESULT` (47,516 rows on live): `YTS_VAL`, `UTS_VAL`,
  `ELONG_VAL`, `R_VAL`, `N_VAL`, `THICKNESS`, `WIDTH`, by coil and `POSITION`.
- **Chemical composition** → **NOT YET LOCATED.** SI/FE/CU/MN/MG/CR/ZN/TI/V/AL are not in
  `CERT_LABEL_DATA_ELEMENTS`. Find this before building the cert.
- **Spec, Country of Cast, Country of Smelt, Born Date** → not yet located.
- **Which customers require a cert** → `CERT_LABEL_CUSTOMERS` = `1153, 1459, 2950` (all Novelis).
- **Which OEM's element list applies** → `customer_order.cert_label_customer_code`
  (`CERT_LABEL_CUSTOMER`: 1=FCA, 2=GM, 3=Ford).

## 4. Open questions

- Which customers use which label variant? Only "per-customer" is known; the mapping is not in any
  table found so far, so it may be code-side.
- What is the extra footer field (`3000032609`)?
- Where does chemical composition come from?
- `w_barcode_item_setup` lets an operator override the identifiers and unit flags per print run. Does
  the plant use it, or are the 2021 defaults always accepted?

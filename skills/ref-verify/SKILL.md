---
name: ref-verify
description: Verify and insert academic references under strict anti-fabrication rules (live DOI check, Q1/Q2 or top-tier CS venue, publisher policy that separates publishing from citing, claim-support check). Use when asked to add a reference, tambah/cari referensi or sitasi, verify a citation, strengthen a claim with literature, or audit whether existing citations are real and correctly attributed. Never insert an unverified reference.
---

# ref-verify: Reference intake and verification

You are verifying and inserting references for an academic manuscript. A fabricated or misattributed citation is the worst possible failure in academic writing: one fake reference makes a reviewer doubt every other claim in the manuscript. Slow and verified beats fast and plausible, every time.

## Inputs

Resolve from the request (ask only if genuinely missing):
- **Target document**: the manuscript or design doc receiving the reference. Default: the working draft the conversation is about.
- **Task shape**: (a) support a specific claim with new reference(s), (b) verify a candidate reference the user supplies, or (c) audit existing citations in a passage.
- **Citation style**: detect from the document's existing References section. Default APA 7.

## Hard rules (never bend)

1. **No reference enters a document before verification passes.** If verification fails or cannot be completed, stop, report, and mark the spot `[UNVERIFIED: <what you looked for>]`.
2. **Publisher policy: separate publishing from citing.** Some institutions steer their authors away from certain publishers as **publishing** venues. The default list here follows Universitas Indonesia and the Indonesian Ministry of Higher Education (Kemendikti): MDPI, Frontiers, and Hindawi. If the user's workspace instructions define a different list, use theirs. Such a policy does not forbid **citing** these publishers, because scholarly norms judge each article on its own merit. So:
   - Citing an article from these publishers is allowed. Judge it per article with Steps 2 to 4, like any other source.
   - When a Q1/Q2 source from another publisher supports the same claim, prefer that source.
   - For any Hindawi article, check retraction status first (publisher notice, Crossref `update-to`/`relation` fields, Retraction Watch database). The 2023 mass retractions make this a real per-article risk. A retracted article is never cited as support.
   - Never propose these publishers as a target venue for the user's own submissions.
   - The list is about choosing a venue to publish in. Bring it up only when the user is choosing one. In verification reports, record the publisher's name instead of labelling a source by list membership ("not MDPI" tells the reader nothing and wrongly implies the list governs citing).
3. **Quality ladder**: prefer Q1/Q2 journals; top-tier CS conferences (NeurIPS, ICML, ICLR, ACL, EMNLP, NAACL, AAAI, and equivalents) count as Q1-equivalent; still prefer a Q1/Q2 journal when both exist.
4. Never edit files or passages the user's workspace instructions mark as frozen (for example archived drafts or provenance statements). If unsure whether a file is frozen, ask.
5. No em dash in any text you write.

## Procedure per reference

Work one reference at a time; parallelize the web lookups when handling a batch.

### Step 1: Find the real paper
Use WebSearch (load it via ToolSearch if needed) with title/author/topic terms. For claim-support mode, search the claim's key concepts plus survey/benchmark terms. Prefer primary sources over blogs and preprints; arXiv is acceptable for CS when it is the canonical version, but check whether a peer-reviewed version exists and cite that instead.

### Step 2: Verify metadata via Crossref/DOI
Fetch `https://api.crossref.org/works/<DOI>` (WebFetch) or resolve `https://doi.org/<DOI>`. Confirm: authors, year, exact title, venue. The record you will write into the document must match this metadata, not your memory. For arXiv-only works, verify via the arXiv abstract page and use the arXiv ID.

### Step 3: Classify the venue
- Journal: check quartile at Scimago (`https://www.scimagojr.com/journalsearch.php?q=<name>`). Record "Q1/Q2/Q3/Q4 (Scimago, <year>)".
- Conference: check membership in the top-tier list above.
- Record the publisher **by name**: the `publisher` field of the Crossref or DataCite record, or the issuing body for documents without a DOI (legislation, court decisions, institutional reports, news). Apply hard rule 2 when relevant: prefer an equivalent Q1/Q2 source from another publisher, and treat the retraction check below as mandatory for Hindawi.
- Record the retraction status. A publisher that retracts or corrects an article links the notice to the original record through the Crossref `update-to` and `relation` fields. Report exactly one of:
  - `none recorded (Crossref)`: the Crossref record carries no such link.
  - `retracted` or `corrected: <notice>`: a notice exists. A retracted article is never cited as support.
  - `not applicable`: legislation, court decisions, institutional reports, news.
  - `not checked (<reason>)`: DataCite DOI, preprint, or no DOI. Never report a source as clean when you could not check it.

### Step 4: Confirm the source supports the claim
Read at least the abstract (full text when reachable). The specific sentence in the manuscript must be something this source actually states or shows. If the source says something adjacent but not that, either soften the manuscript sentence (say so) or find a better source. This is the citation-misattribution check; treat it as mandatory, not optional.

### Step 5: Insert
- Check the References section for an existing entry (avoid duplicates; reuse the existing key/format).
- Add the in-text citation in the document's existing style and the full entry in References, alphabetically placed, DOI included.
- If the document tracks a recency mix (target: ≥ 40% of references from the last 5 years), recompute and report the new ratio.

### Step 6: Report
End with one verification table for the batch:

| Ref | DOI live | Metadata match | Venue class (evidence) | Publisher | Retraction status | Supports claim | Action |
|---|---|---|---|---|---|---|---|

Every row must be filled from checks you actually ran this session. Below the table, list anything left `[UNVERIFIED]` and what decision you need from the user, as numbered options.

## Audit mode (existing citations)

For each citation in the passage: run Steps 2 to 4 against the existing entry. Classify as VERIFIED / METADATA MISMATCH / MISATTRIBUTED (source does not support the sentence) / NOT FOUND (possible fabrication). Report in the same table plus a severity-ordered fix list. Do not change the manuscript until the user approves the fixes.

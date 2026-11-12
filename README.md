# ref-verify

Skill agent untuk menambah dan mengaudit referensi akademik tanpa sitasi karangan. Setiap referensi baru masuk naskah setelah lolos empat pemeriksaan: DOI-nya hidup, metadatanya cocok, venue-nya bermutu, dan isinya benar-benar mendukung kalimat yang disitasi.

Skill ini dibaca oleh Claude Code, Codex, atau agent lain yang mendukung berkas `SKILL.md`. Ia memakai kemampuan web search dan web fetch milik agent. Tidak ada layanan atau kredensial yang dibundel.

## Tiga mode

| Mode | Kapan dipakai |
|---|---|
| Dukungan klaim | Sebuah kalimat di naskah butuh referensi |
| Verifikasi kandidat | Anda sudah punya satu referensi dan ingin memastikan ia sah |
| Audit | Sitasi yang sudah ada di naskah perlu diperiksa |

## Enam langkah per referensi

1. **Cari paper aslinya.** Versi peer-reviewed didahulukan daripada preprint.
2. **Resolusi DOI.** DOI (Digital Object Identifier) adalah kode unik permanen tiap terbitan. Metadata diambil dari Crossref atau doi.org, bukan dari ingatan model.
3. **Klasifikasi venue.** Kuartil jurnal dicek di Scimago. Konferensi CS papan atas dihitung setara Q1.
4. **Cek dukungan klaim.** Paling tidak abstraknya dibaca. Sumber yang hanya membahas hal berdekatan tidak dipakai untuk klaim itu.
5. **Sisipkan.** Gaya sitasi mengikuti dokumen, default APA 7, tanpa entri ganda.
6. **Laporkan** dalam satu tabel verifikasi. Referensi yang gagal ditandai `[UNVERIFIED]`.

Mode audit memberi label VERIFIED, METADATA MISMATCH, MISATTRIBUTED, atau NOT FOUND, dan naskah baru diubah setelah pengguna menyetujui perbaikannya.

## Kebijakan penerbit

Daftar bawaannya mengikuti kebijakan Universitas Indonesia dan Kemendikti: MDPI, Frontiers, dan Hindawi dihindari sebagai tempat menerbitkan. Kalau instruksi workspace Anda punya daftar lain, skill memakai daftar itu. Ketiganya tetap boleh disitasi dan dinilai per artikel. Sumber Q1/Q2 dari penerbit lain didahulukan untuk klaim yang sama, dan artikel Hindawi dicek status retraksinya lebih dulu.

## Pemasangan

```sh
./install.sh
```

Script ini membuat symlink `skills/ref-verify` ke `~/.claude/skills/` dan `~/.agents/skills/`. Setelah itu panggil `/ref-verify` di Claude Code, atau sebut namanya di Codex.

## Lisensi

MIT. Lihat [LICENSE](LICENSE).

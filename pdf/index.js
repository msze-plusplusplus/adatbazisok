const { mdToPdf } = require("md-to-pdf");

const content = require("child_process").execSync(
  "awk 'FNR==1{print \"\"}{print}' docs/*.md | sed '1d'"
);

const html = {
  as_html: true,
  dest: "docs/index.html",
};

const config = {
  basedir: "docs/",
  dest: "docs/webtarhely_adatbazis_plusplusplus.pdf",
  stylesheet: "style.css",
  marked_options: {
    gfm: true,
  },
  pdf_options: {
    format: "a4",
    margin: "30mm 20mm",
    headerTemplate: `
<style>
section {
    font-family: system-ui;
    font-size: 10px;
    width: calc(100% - 32mm);
    margin: 0 16mm;
}

section.header {
    margin-top: 1mm;
}

section.header span {
    display: inline-block;
    width: 50%;
    vertical-align: top;
    text-align: left;
}

section.header span:last-child {
    text-align: right;
    float: right;
}

section.footer .page-number {
    float: right;
}
</style>
<section class="header">
    <span>Baranyai Bence Bendegúz<br/>Karcag Tamás</span>
    <span>2020/2021-02<br/>GKNB_INTM010</span>
</section>`,
    footerTemplate: `
<section class="footer">
    <span>${new Date().toLocaleString("HU")}</span>
    <div class="page-number">
        <span class="pageNumber"></span> / <span class="totalPages"></span>
    </div>
</section>`,
  },
};

mdToPdf(
  {
    content,
  },
  config
);

mdToPdf(
  {
    content,
  },
  { ...config, ...html }
);

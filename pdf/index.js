const { mdToPdf } = require("md-to-pdf");

let content = require("child_process").execSync(
  "awk 'FNR==1{print \"\"}{print}' docs/*.md | sed '1d'"
);

const html = {
  as_html: true,
  dest: "docs/index.html",
};

const currentDate = new Date().toLocaleString("HU", {
  timeZone: "Europe/Budapest",
  year: "numeric",
  month: "2-digit",
  day: "2-digit",
  hour: "2-digit",
  minute: "2-digit",
  second: "2-digit",
});

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

section.footer span.sign {
  display: block;
  font-size: 4px;
}
</style>
<section class="header">
    <span>Baranyai Bence Bendegúz<br/>Karcag Tamás</span>
    <span>2020/2021-02<br/>GKNB_INTM010</span>
</section>`,
    footerTemplate: `
<section class="footer">
    <span>${currentDate}</span>
    <div class="page-number">
        <span class="pageNumber"></span> / <span class="totalPages"></span>
    </div>
    <span class="sign">${
      process.env.GITHUB_REPOSITORY || "Helyben generált"
    } - Feltöltő: ${
      process.env.GITHUB_ACTOR || require("os").userInfo().username || ""
    } ${
      process.env.GITHUB_SHA ? "- Commit: " + process.env.GITHUB_SHA : ""
    }</span>
</section>`,
  },
};

content = content
  .toString()
  .replace(
    "#EMBED#",
    `Frissítve: ${currentDate} Feltöltő: ${
      process.env.GITHUB_ACTOR || require("os").userInfo().username || ""
    } ${process.env.GITHUB_SHA ? "- Commit: " + process.env.GITHUB_SHA : ""}`
  );

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

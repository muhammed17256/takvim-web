window.T = {
  VERSION: "__APP_VERSION__".startsWith("__") ? "dev" : "__APP_VERSION__",
  KEY: "takvim-etkinlikler",
  MONTHS: ["Ocak","Şubat","Mart","Nisan","Mayıs","Haziran","Temmuz","Ağustos","Eylül","Ekim","Kasım","Aralık"],
  DAYS: ["Pazar","Pazartesi","Salı","Çarşamba","Perşembe","Cuma","Cumartesi"],
  pad: n => String(n).padStart(2, "0"),
  ymd: d => d.getFullYear() + "-" + String(d.getMonth() + 1).padStart(2, "0") + "-" + String(d.getDate()).padStart(2, "0"),
  load() { try { return JSON.parse(localStorage.getItem(this.KEY)) || {}; } catch (e) { return {}; } },
  save(ev) { try { localStorage.setItem(this.KEY, JSON.stringify(ev)); } catch (e) {} }
};
(function () {
  const pages = [["index.html", "Takvim"], ["etkinlikler.html", "Etkinlikler"], ["tatiller.html", "Tatiller"], ["hakkinda.html", "Hakkında"]];
  const cur = location.pathname.split("/").pop() || "index.html";
  const links = pages.map(p => '<a href="' + p[0] + '"' + (p[0] === cur ? ' class="on"' : '') + '>' + p[1] + '</a>').join("");
  document.body.insertAdjacentHTML("afterbegin", '<nav class="top"><div class="in"><b>📅 Takvim</b>' + links + '</div></nav>');
})();

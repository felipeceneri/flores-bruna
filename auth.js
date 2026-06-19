(function () {
  var KEY = 'fb_auth';

  window.getSession = function () {
    try { return JSON.parse(sessionStorage.getItem(KEY)); } catch (e) { return null; }
  };

  window.setSession = function (data) {
    sessionStorage.setItem(KEY, JSON.stringify(data));
  };

  window.logout = function () {
    sessionStorage.removeItem(KEY);
    window.location.replace('login.html');
  };

  window.checkAuth = function (perm) {
    var s = window.getSession();
    if (!s) { window.location.replace('login.html'); return; }
    if (perm && (!Array.isArray(s.permissoes) || s.permissoes.indexOf(perm) === -1)) {
      window.location.replace('login.html');
      return;
    }
    document.addEventListener('DOMContentLoaded', function () { _applyNav(s); });
  };

  function _applyNav(session) {
    document.querySelectorAll('[data-perm]').forEach(function (el) {
      if (session.permissoes.indexOf(el.dataset.perm) === -1) el.style.display = 'none';
    });

    var footer = document.querySelector('.sidebar-footer');
    if (!footer) return;

    var div = document.createElement('div');
    div.style.cssText = 'display:flex;align-items:center;justify-content:space-between;padding:.5rem .75rem;margin-bottom:.5rem;background:rgba(79,111,255,.08);border-radius:8px;border:1px solid rgba(79,111,255,.2);gap:6px;';

    var nameEl = document.createElement('span');
    nameEl.style.cssText = 'font-size:12px;font-weight:600;color:var(--text);overflow:hidden;text-overflow:ellipsis;white-space:nowrap;';
    nameEl.title = session.nome;
    nameEl.textContent = '👤 ' + session.nome;

    var btn = document.createElement('button');
    btn.style.cssText = 'background:transparent;border:1px solid var(--border);border-radius:6px;padding:3px 8px;font-size:11px;color:var(--text-2);cursor:pointer;font-family:var(--font);flex-shrink:0;';
    btn.textContent = 'Sair';
    btn.onclick = window.logout;
    btn.onmouseover = function () { this.style.borderColor = 'var(--danger)'; this.style.color = 'var(--danger)'; };
    btn.onmouseout = function () { this.style.borderColor = 'var(--border)'; this.style.color = 'var(--text-2)'; };

    div.appendChild(nameEl);
    div.appendChild(btn);
    footer.prepend(div);
  }
})();

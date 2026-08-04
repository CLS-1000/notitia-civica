/* ============================================================
   support.js — Notitia Civica Design System Utilities
   Imported by: Notitia Civica.dc.html
   ============================================================ */

(function (NC) {

  /* ── Token registry ───────────────────────────────────────── */
  NC.tokens = {
    colors: [
      /* Neutral */
      { name: '--nc-ink',       value: '#1F1C16', label: 'Ink',        desc: 'Primary text',              group: 'neutral' },
      { name: '--nc-ink-2',     value: '#3D3830', label: 'Ink 2',      desc: 'Secondary text',             group: 'neutral' },
      { name: '--nc-ink-3',     value: '#78726A', label: 'Ink 3',      desc: 'Labels / captions',          group: 'neutral' },
      { name: '--nc-plaster',   value: '#F7F4EE', label: 'Plaster',    desc: 'Primary background',         group: 'neutral' },
      { name: '--nc-bone',      value: '#EDE8DE', label: 'Bone',       desc: 'Section / panel background', group: 'neutral' },
      { name: '--nc-oat',       value: '#E3DDD2', label: 'Oat',        desc: 'Deep background',            group: 'neutral' },
      { name: '--nc-line',      value: '#D2CDC3', label: 'Line',       desc: 'Light rule / border',        group: 'neutral' },
      { name: '--nc-line-dark', value: '#1F1C16', label: 'Line Dark',  desc: 'Heavy rule',                 group: 'neutral' },
      /* Series accents */
      { name: '--nc-sienna',    value: '#B83820', label: 'Sienna',     desc: 'World State Brief',          group: 'accent'  },
      { name: '--nc-ochre',     value: '#A86B1E', label: 'Ochre',      desc: 'Narrative Operations',       group: 'accent'  },
      { name: '--nc-teal',      value: '#266662', label: 'Teal',       desc: 'Civic Intelligence',         group: 'accent'  },
      { name: '--nc-navy',      value: '#1A2D50', label: 'Navy',       desc: 'Congressional Intelligence', group: 'accent'  },
      { name: '--nc-olive',     value: '#4A5E28', label: 'Olive',      desc: 'Financial',                  group: 'accent'  },
    ],
    type: [
      {
        name:   '--nc-serif',
        label:  'Serif',
        value:  '"Libre Caslon Text", "Iowan Old Style", Georgia, serif',
        sample: 'Aa',
        note:   'Editorial authority — body, headlines, pull quotes',
      },
      {
        name:   '--nc-sans',
        label:  'Sans',
        value:  '"Inter", system-ui, -apple-system, "Helvetica Neue", Arial, sans-serif',
        sample: 'Aa',
        note:   'Interface chrome — kickers, labels, buttons',
      },
      {
        name:   '--nc-mono',
        label:  'Mono',
        value:  '"Courier Prime", "Courier New", Courier, monospace',
        sample: 'Aa',
        note:   'Data + provenance — scores, IDs, metadata values',
      },
    ],
  };

  /* ── Clipboard ────────────────────────────────────────────── */
  NC.copy = function (text) {
    if (navigator.clipboard && navigator.clipboard.writeText) {
      navigator.clipboard.writeText(text).catch(function () { NC._legacyCopy(text); });
    } else {
      NC._legacyCopy(text);
    }
  };

  NC._legacyCopy = function (text) {
    var ta = document.createElement('textarea');
    ta.value = text;
    ta.style.cssText = 'position:fixed;opacity:0;pointer-events:none;top:0;left:0';
    document.body.appendChild(ta);
    ta.focus();
    ta.select();
    try { document.execCommand('copy'); } catch (_) {}
    document.body.removeChild(ta);
  };

  /* ── Flash "copied" state ─────────────────────────────────── */
  NC.flashCopied = function (el) {
    el.classList.add('nc-copied');
    clearTimeout(el._ncCopyTimer);
    el._ncCopyTimer = setTimeout(function () { el.classList.remove('nc-copied'); }, 1400);
  };

  /* ── Color swatch renderer ───────────────────────────────── */
  NC.renderSwatches = function (containerId, tokens) {
    var container = document.getElementById(containerId);
    if (!container) return;

    var prevGroup = null;
    tokens.forEach(function (t) {
      if (t.group && t.group !== prevGroup) {
        var groupHead = document.createElement('div');
        groupHead.className = 'nc-swatch-group-head';
        groupHead.textContent = t.group === 'neutral' ? 'Neutral scale' : 'Series accents';
        container.appendChild(groupHead);
        prevGroup = t.group;
      }

      var swatch = document.createElement('div');
      swatch.className = 'nc-swatch';
      swatch.title = 'Click to copy ' + t.name;
      swatch.innerHTML =
        '<div class="nc-swatch-color" style="background:' + t.value + ';' +
          (NC._isLight(t.value) ? 'border-bottom:1px solid #d2cdc3;' : '') +
        '"></div>' +
        '<div class="nc-swatch-info">' +
          '<span class="nc-swatch-label">' + t.label + '</span>' +
          '<code class="nc-swatch-name">' + t.name + '</code>' +
          '<span class="nc-swatch-value">' + t.value + '</span>' +
          (t.desc ? '<span class="nc-swatch-desc">' + t.desc + '</span>' : '') +
        '</div>';

      swatch.addEventListener('click', function () {
        NC.copy(t.name);
        NC.flashCopied(swatch);
      });

      container.appendChild(swatch);
    });
  };

  /* Luminance check — flag light-on-light swatches */
  NC._isLight = function (hex) {
    var r = parseInt(hex.slice(1, 3), 16) / 255;
    var g = parseInt(hex.slice(3, 5), 16) / 255;
    var b = parseInt(hex.slice(5, 7), 16) / 255;
    return (0.299 * r + 0.587 * g + 0.114 * b) > 0.7;
  };

  /* ── Typography sample renderer ─────────────────────────── */
  NC.renderTypeSamples = function (containerId, tokens) {
    var container = document.getElementById(containerId);
    if (!container) return;

    tokens.forEach(function (t) {
      var item = document.createElement('div');
      item.className = 'nc-type-item';
      item.innerHTML =
        '<div class="nc-type-sample" style="font-family:' + t.value + '">' + t.sample + '</div>' +
        '<div class="nc-type-meta">' +
          '<div class="nc-type-family">' + t.label + '</div>' +
          '<code class="nc-type-token">' + t.name + '</code>' +
          '<span class="nc-type-note">' + (t.note || '') + '</span>' +
        '</div>';
      container.appendChild(item);
    });
  };

  /* ── Accent switcher ─────────────────────────────────────── */
  NC.setAccent = function (tokenName) {
    document.documentElement.style.setProperty('--nc-accent', 'var(' + tokenName + ')');
    document.querySelectorAll('.nc-accent-btn').forEach(function (btn) {
      btn.classList.toggle('active', btn.dataset.token === tokenName);
    });
  };

  /* ── Active-section nav highlight ────────────────────────── */
  NC.initNav = function () {
    var links = document.querySelectorAll('.nc-dc-nav a[href^="#"]');
    if (!links.length) return;

    var observer = new window.IntersectionObserver(
      function (entries) {
        entries.forEach(function (entry) {
          var id = entry.target.id;
          var link = document.querySelector('.nc-dc-nav a[href="#' + id + '"]');
          if (link) link.classList.toggle('active', entry.isIntersecting);
        });
      },
      { threshold: 0.25, rootMargin: '0px 0px -40% 0px' }
    );

    document.querySelectorAll('section[id]').forEach(function (el) {
      observer.observe(el);
    });
  };

  /* ── Init ────────────────────────────────────────────────── */
  NC.init = function () {
    NC.renderSwatches('nc-color-tokens', NC.tokens.colors);
    NC.renderTypeSamples('nc-type-tokens', NC.tokens.type);
    NC.initNav();
  };

}(window.NC = window.NC || {}));

document.addEventListener('DOMContentLoaded', NC.init);

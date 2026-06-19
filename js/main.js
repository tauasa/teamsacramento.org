/* ==========================================================================
   Team Sacramento Judo - site behavior (no framework, no build step)
   - Hamburger menu + mobile "Home" accordion
   - Desktop "Home" dropdown (hover on desktop, click/keyboard everywhere)
   - Active nav link highlighting, driven by <body data-page="...">
   - Footer copyright year
   - Join page contact form -> opens a pre-filled email (no backend)
   ========================================================================== */

document.addEventListener('DOMContentLoaded', function () {
  initNav();
  initFooterYear();
  initContactForm();
});

function initNav() {
  var hamburger = document.querySelector('.nav__hamburger');
  var mobileMenu = document.querySelector('.nav__mobile');
  var mobileHomeTrigger = document.querySelector('.nav__mobile-link--trigger');
  var mobileSubmenu = document.querySelector('.nav__mobile-submenu');
  var desktopTrigger = document.querySelector('.nav__link--trigger');
  var desktopDropdown = document.querySelector('.nav__dropdown');
  var desktopSubmenu = document.querySelector('.nav__submenu');

  function closeMobile() {
    if (!hamburger || !mobileMenu) return;
    hamburger.classList.remove('is-open');
    hamburger.setAttribute('aria-expanded', 'false');
    mobileMenu.classList.remove('is-open');
    if (mobileSubmenu) mobileSubmenu.classList.remove('is-open');
    if (mobileHomeTrigger) mobileHomeTrigger.setAttribute('aria-expanded', 'false');
  }

  function closeDesktopDropdown() {
    if (!desktopSubmenu || !desktopTrigger) return;
    desktopSubmenu.classList.remove('is-open');
    desktopTrigger.setAttribute('aria-expanded', 'false');
  }

  // Hamburger toggle
  if (hamburger && mobileMenu) {
    hamburger.addEventListener('click', function () {
      var isOpen = mobileMenu.classList.toggle('is-open');
      hamburger.classList.toggle('is-open', isOpen);
      hamburger.setAttribute('aria-expanded', String(isOpen));
      if (!isOpen) closeMobile();
    });
  }

  // Mobile "Home" accordion
  if (mobileHomeTrigger && mobileSubmenu) {
    mobileHomeTrigger.addEventListener('click', function () {
      var isOpen = mobileSubmenu.classList.toggle('is-open');
      mobileHomeTrigger.setAttribute('aria-expanded', String(isOpen));
      var caret = mobileHomeTrigger.querySelector('.nav__caret');
      if (caret) caret.classList.toggle('is-open', isOpen);
    });
  }

  // Desktop "Home" dropdown - click/keyboard toggle (hover is handled in CSS)
  if (desktopTrigger && desktopSubmenu && desktopDropdown) {
    desktopTrigger.addEventListener('click', function (event) {
      event.stopPropagation();
      var isOpen = desktopSubmenu.classList.toggle('is-open');
      desktopTrigger.setAttribute('aria-expanded', String(isOpen));
    });

    document.addEventListener('click', function (event) {
      if (!desktopDropdown.contains(event.target)) {
        closeDesktopDropdown();
      }
    });
  }

  document.addEventListener('keydown', function (event) {
    if (event.key === 'Escape') {
      closeDesktopDropdown();
      closeMobile();
    }
  });

  // Close the mobile panel if the viewport is resized up past the breakpoint
  window.addEventListener('resize', function () {
    if (window.innerWidth > 880) closeMobile();
  });

  highlightActiveLink();
}

function highlightActiveLink() {
  var currentPage = document.body.getAttribute('data-page');
  if (!currentPage) return;

  var links = document.querySelectorAll('[data-nav]');
  links.forEach(function (link) {
    if (link.getAttribute('data-nav') === currentPage) {
      link.setAttribute('aria-current', 'page');
    }
  });

  // If the active page lives under the Home dropdown (About/History/Coaches),
  // style the "Home" trigger itself as active too.
  var subPages = ['about', 'history', 'coaches'];
  if (subPages.indexOf(currentPage) !== -1) {
    var homeTriggers = document.querySelectorAll('[data-nav="home-trigger"]');
    homeTriggers.forEach(function (trigger) {
      trigger.setAttribute('aria-current', 'page');
    });
  }
}

function initFooterYear() {
  var yearEl = document.getElementById('copyright-year');
  if (yearEl) {
    yearEl.textContent = new Date().getFullYear();
  }
}

function initContactForm() {
  var form = document.getElementById('contact-form');
  if (!form) return;

  var statusEl = document.getElementById('form-status');

  form.addEventListener('submit', function (event) {
    event.preventDefault();

    var name = form.elements['name'].value.trim();
    var email = form.elements['email'].value.trim();
    var phone = form.elements['phone'].value.trim();
    var message = form.elements['message'].value.trim();

    // Native HTML5 validation (required / type="email") runs before this
    // point via reportValidity, so by here the fields are already valid.
    if (!form.reportValidity()) return;

    var subject = 'Team Sacramento Judo - message from ' + name;
    var bodyLines = [
      message,
      '',
      '---',
      'Name: ' + name,
      'Email: ' + email
    ];
    if (phone) bodyLines.push('Phone: ' + phone);

    var mailto =
      'mailto:info@teamsacramento.org' +
      '?subject=' + encodeURIComponent(subject) +
      '&body=' + encodeURIComponent(bodyLines.join('\n'));

    window.location.href = mailto;

    if (statusEl) {
      statusEl.textContent =
        "Opening your email app with this message filled in - just hit send there to reach us.";
      statusEl.classList.add('is-visible');
    }
  });
}

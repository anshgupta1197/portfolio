const revealTargets = document.querySelectorAll('.reveal');
const recruiterToggle = document.getElementById('toggleRecruiterMode');
const copyButtons = document.querySelectorAll('[data-copy-text]');
const copyStatus = document.getElementById('copyStatus');
const experienceYears = document.getElementById('experienceYears');
const focusValue = document.getElementById('focusValue');
const contactForm = document.getElementById('contactForm');
const formStatus = document.getElementById('formStatus');

const observer = new IntersectionObserver(
  (entries) => {
    entries.forEach((entry) => {
      if (entry.isIntersecting) {
        entry.target.classList.add('visible');
        observer.unobserve(entry.target);
      }
    });
  },
  { threshold: 0.12 }
);

revealTargets.forEach((target) => observer.observe(target));

let recruiterMode = false;
recruiterToggle.addEventListener('click', () => {
  recruiterMode = !recruiterMode;
  document.body.classList.toggle('recruiter-mode', recruiterMode);
  recruiterToggle.textContent = `Recruiter Mode: ${recruiterMode ? 'On' : 'Off'}`;
});

copyButtons.forEach((button) => {
  button.addEventListener('click', async () => {
    const copyText = button.getAttribute('data-copy-text') || '';
    const copyLabel = button.getAttribute('data-copy-label') || 'Text';

    try {
      await navigator.clipboard.writeText(copyText);
      if (copyStatus) {
        copyStatus.textContent = `${copyLabel} copied to clipboard.`;
      }
    } catch (error) {
      if (copyStatus) {
        copyStatus.textContent = 'Copy failed. Please copy manually.';
      }
    }

    if (copyStatus) {
      setTimeout(() => {
        copyStatus.textContent = '';
      }, 2200);
    }
  });
});

if (contactForm) {
  contactForm.addEventListener('submit', async (event) => {
    event.preventDefault();

    const formData = new FormData(contactForm);
    const accessKey = String(formData.get('access_key') || '').trim();
    const name = String(formData.get('name') || '').trim();
    const email = String(formData.get('email') || '').trim();
    const subject = String(formData.get('subject') || '').trim();
    const message = String(formData.get('message') || '').trim();
    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    if (!accessKey || accessKey === 'REPLACE_WITH_WEB3FORMS_ACCESS_KEY') {
      formStatus.textContent = 'Form setup pending: add your Web3Forms access key to enable delivery.';
      formStatus.classList.add('error');
      return;
    }

    if (!name || !email || !subject || !message) {
      formStatus.textContent = 'Please fill all fields before sending.';
      formStatus.classList.add('error');
      return;
    }

    if (!emailPattern.test(email)) {
      formStatus.textContent = 'Please enter a valid email address.';
      formStatus.classList.add('error');
      return;
    }

    formStatus.classList.remove('error');
    formStatus.textContent = 'Sending your message...';
    formData.set('replyto', email);
    formData.set('subject', subject);

    const submitButton = contactForm.querySelector('button[type="submit"]');
    if (submitButton) {
      submitButton.disabled = true;
      submitButton.textContent = 'Sending...';
    }

    try {
      const response = await fetch(contactForm.action, {
        method: 'POST',
        body: formData,
        headers: {
          Accept: 'application/json'
        }
      });
      const data = await response.json();

      if (!response.ok || !data.success) {
        throw new Error('Request failed');
      }

      formStatus.classList.remove('error');
      formStatus.textContent = 'Message sent successfully. I will get back to you soon.';
      contactForm.reset();
    } catch (error) {
      formStatus.classList.add('error');
      formStatus.textContent = 'Message could not be sent right now. Please try again in a moment.';
    } finally {
      if (submitButton) {
        submitButton.disabled = false;
        submitButton.textContent = 'Send Message';
      }
    }
  });
}

experienceYears.textContent = '6+';

if (focusValue) {
  const focusItems = [
    'Automation reliability',
    'API quality at scale',
    'Release confidence',
    'Regression optimization'
  ];

  let focusIndex = 0;
  setInterval(() => {
    focusIndex = (focusIndex + 1) % focusItems.length;
    focusValue.textContent = focusItems[focusIndex];
  }, 2200);
}

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    delay: Number
  }

  static targets = ["attack", "timer", "time"];

  connect() {
    this.startTimer();
  }

  enableAttack() {
    this.attackTarget.disabled = false;
    this.timerTarget.style.display = 'none';
  }

  startTimer() {
    let timeLeft = this.delayValue;
    
    this.timeTarget.textContent = timeLeft.toFixed(1);

    const timeInterval = setInterval(() => {
      timeLeft -= 0.1;
      if (timeLeft <= 0) {
        clearInterval(timeInterval);
        this.timeTarget.textContent = '0.0';
        this.enableAttack();
      } else {
        this.timerTarget.style.display = 'block';
        this.timeTarget.textContent = timeLeft.toFixed(1);
      }
    }, 100);
  }
}

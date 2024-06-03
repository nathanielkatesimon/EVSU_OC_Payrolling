import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="part-time-entries"
export default class extends Controller {
  static targets = ["gross", "net"]

  calculate(event) {
    clearTimeout(this.interval)
    this.interval = setTimeout(async () => {
      let { authenticityToken, id } = event.target.dataset
      let csrfToken = document.querySelector('meta[name="csrf-token"]').content

      let data = { 'authenticity_token': authenticityToken, 'total_rendered_hours': event.target.value }

      let res = await fetch("/part_time_entries/calculate/" + id, { method: "PATCH", body: JSON.stringify(data), headers: { "Content-Type": "application/json", "X-CSRF-Token": csrfToken } })
      let res_json = await res.json()

      if (res_json.success) {
        this.grossTarget.innerText = res_json.gross
        this.netTarget.innerText = res_json.net
      }
    }, 300)
  }
}

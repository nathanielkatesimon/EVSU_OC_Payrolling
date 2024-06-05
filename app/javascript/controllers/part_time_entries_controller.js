import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="part-time-entries"
export default class extends Controller {
  static targets = ["gross", "net", "total_rendered_hours", "total_deductions"]

  calculate(event) {
    clearTimeout(this.interval)
    this.interval = setTimeout(async () => {
      let { authenticityToken, id, value } = event.target.dataset
      let csrfToken = document.querySelector('meta[name="csrf-token"]').content

      let data = { 'authenticity_token': authenticityToken, "part_time_entry": {} }
      data["part_time_entry"][value] = event.target.value || 0.0


      let res = await fetch("/part_time_entries/calculate/" + id, { method: "PATCH", body: JSON.stringify(data), headers: { "Content-Type": "application/json", "X-CSRF-Token": csrfToken } })
      let res_json = await res.json()

      if (res_json.success) {
        this.grossTarget.innerText = res_json.gross
        this.netTarget.innerText = res_json.net
        this.total_rendered_hoursTarget.innerText = res_json.total_rendered_hours
        this.total_deductionsTarget.innerText = res_json.total_deductions
      }
    }, 300)
  }
}

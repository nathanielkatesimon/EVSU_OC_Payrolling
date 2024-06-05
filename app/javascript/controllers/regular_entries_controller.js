import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="regular-entries"
export default class extends Controller {
  static targets = ["gross", "net", "gsis_ps", "first_quincena", "second_quincena", "total_deductions"]

  calculate(event) {
    clearTimeout(this.interval)
    this.interval = setTimeout(async () => {
      let { authenticityToken, id, value } = event.target.dataset
      let csrfToken = document.querySelector('meta[name="csrf-token"]').content

      let data = { 'authenticity_token': authenticityToken, "regular_entry": {} }
      data["regular_entry"][value] = event.target.value || 0.0


      let res = await fetch("/regular_entries/calculate/" + id, { method: "PATCH", body: JSON.stringify(data), headers: { "Content-Type": "application/json", "X-CSRF-Token": csrfToken } })
      let res_json = await res.json()

      if (res_json.success) {
        this.grossTarget.innerText = res_json.gross
        this.netTarget.innerText = res_json.net
        this.gsis_psTarget.innerText = res_json.gsis_ps
        this.first_quincenaTarget.innerText = res_json.first_quincena
        this.second_quincenaTarget.innerText = res_json.second_quincena
        this.total_deductionsTarget.innerText = res_json.total_deductions
      }
    }, 300)
  }
}

import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="cos-entries"
export default class extends Controller {
  static targets = ["gross", "net", "late_or_undertime_deduction", "overtime_comp", "total_deductions", "summed_up_no_of_worked_days"]

  calculate(event) {
    clearTimeout(this.interval)
    this.interval = setTimeout(async () => {
      let { authenticityToken, id, value } = event.target.dataset
      let csrfToken = document.querySelector('meta[name="csrf-token"]').content

      let data = { 'authenticity_token': authenticityToken, "cos_entry": {} }
      data["cos_entry"][value] = event.target.value || 0.0


      let res = await fetch("/cos_entries/calculate/" + id, { method: "PATCH", body: JSON.stringify(data), headers: { "Content-Type": "application/json", "X-CSRF-Token": csrfToken } })
      let res_json = await res.json()

      if (res_json.success) {
        this.grossTarget.innerText = res_json.gross
        this.netTarget.innerText = res_json.net
        this.late_or_undertime_deductionTarget.innerText = res_json.late_or_undertime_deduction
        this.overtime_compTarget.innerText = res_json.overtime_comp
        this.summed_up_no_of_worked_daysTarget.innerText = res_json.total_no_of_days
        this.total_deductionsTarget.innerText = res_json.total_deductions
      }
    }, 300)
  }
}

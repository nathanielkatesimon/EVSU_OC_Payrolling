import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="cos-entries"
export default class extends Controller {
  static targets = ["gross", "net", "undertime", "overtime"]

  calculate(event) {
    clearTimeout(this.interval)
    this.interval = setTimeout(async () => {
      let { authenticityToken, id, value } = event.target.dataset
      let csrfToken = document.querySelector('meta[name="csrf-token"]').content
      
      let data = { 'authenticity_token': authenticityToken, "cos_entry": {} }
      data["cos_entry"][value] = event.target.value


      let res = await fetch("/cos_entries/calculate/" + id, { method: "PATCH", body: JSON.stringify(data), headers: { "Content-Type": "application/json", "X-CSRF-Token": csrfToken } })
      let res_json = await res.json()

      if (res_json.success) {
        this.grossTarget.innerText = res_json.gross
        this.netTarget.innerText = res_json.net
        this.undertimeTarget.innerText = res_json.undertime
        this.overtimeTarget.innerText = res_json.overtime
      }
    }, 300)
  }
}

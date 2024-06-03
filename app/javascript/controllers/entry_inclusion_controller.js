import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="entry-inclusion"
export default class extends Controller {
  updateEntryInclusion() {
    let { entryType, entryId, authenticityToken } = this.element.dataset

    let url = undefined
    let csrfMetaTag = document.querySelector('meta[name="csrf-token"]').content
    let data = { 'authenticity_token': authenticityToken }

    if (entryType == "part_time") {
      url = "/part_time_entries/" + (this.element.checked ? "approve/" : "reject/") + entryId
    }

    fetch(url, { method: "PATCH", body: JSON.stringify(data), headers: { "Content-Type": "application/json", "X-CSRF-Token": csrfMetaTag } })
  }
}

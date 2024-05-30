import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="ada-printer"
export default class extends Controller {
  print() {
    document.getElementById("header").classList.add("d-none")
    document.getElementById("printBtn").classList.add("d-none")
    window.print()
    document.getElementById("header").classList.remove("d-none")
    document.getElementById("printBtn").classList.remove("d-none")
  }
}

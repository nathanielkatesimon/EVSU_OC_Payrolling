import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="payroll-printer"
export default class extends Controller {
  print() {
    document.getElementById("header").classList.add("d-none")
    document.getElementById("printBtn").classList.add("d-none")
    document.getElementById("viewAdaBtn").classList.add("d-none")
    document.getElementById("payroll_title").classList.add("d-none")
    document.getElementById('print_table').classList.remove('table-responsive')
    document.getElementById('print_table').classList.add('print_font')

    window.print()

    document.getElementById("header").classList.remove("d-none")
    document.getElementById("printBtn").classList.remove("d-none")
    document.getElementById("viewAdaBtn").classList.remove("d-none")
    document.getElementById("payroll_title").classList.remove("d-none")
    document.getElementById('print_table').classList.add('table-responsive')
    document.getElementById('print_table').classList.remove('print_font')
  }
}

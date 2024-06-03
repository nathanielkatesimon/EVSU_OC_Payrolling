import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="users--create"
export default class extends Controller {
  static targets = ["employeeTypeSelection", "regularsSalaryForm", "cosSalaryForm", "partTimeSalaryForm"]

  connect() {
    if (this.employeeTypeSelectionTarget.value == "regular") {
      this.regularsSalaryFormTarget.classList.remove("d-none")
      this.prevElement = this.regularsSalaryFormTarget
    }
    else if (this.employeeTypeSelectionTarget.value == "cos") {
      this.cosSalaryFormTarget.classList.remove("d-none")
      this.prevElement = this.cosSalaryFormTarget
    }
    else if (this.employeeTypeSelectionTarget.value == "part_time") {
      this.partTimeSalaryFormTarget.classList.remove("d-none")
      this.prevElement = this.partTimeSalaryFormTarget
    }
  }

  displayCorrespondingSalaryForm() {
    if (this.employeeTypeSelectionTarget.value == "regular") {
      this.prevElement.classList.add("d-none")
      this.regularsSalaryFormTarget.classList.remove("d-none")
      this.prevElement = this.regularsSalaryFormTarget
    }
    else if (this.employeeTypeSelectionTarget.value == "cos") {
      this.prevElement.classList.add("d-none")
      this.cosSalaryFormTarget.classList.remove("d-none")
      this.prevElement = this.cosSalaryFormTarget
    }
    else if (this.employeeTypeSelectionTarget.value == "part_time") {
      this.prevElement.classList.add("d-none")
      this.partTimeSalaryFormTarget.classList.remove("d-none")
      this.prevElement = this.partTimeSalaryFormTarget
    }
  }
}

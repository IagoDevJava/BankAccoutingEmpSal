package com.anybank.bankemployeessalaries.check;

import com.anybank.bankemployeessalaries.dto.EmployeeDto;
import com.anybank.bankemployeessalaries.enum_model.JobStatus;
import com.anybank.bankemployeessalaries.exception.EmployeeNotFoundException;
import com.anybank.bankemployeessalaries.model.Employee;
import com.anybank.bankemployeessalaries.repository.EmployeeRepository;
import com.anybank.bankemployeessalaries.service.EmployeeService;
import lombok.RequiredArgsConstructor;

import java.time.LocalDateTime;

@RequiredArgsConstructor
public class CheckDataOfEmployees {
    private EmployeeService employeeService;
    private EmployeeRepository employeeRepository;

    public void checkData() {
        checkStatusEmployee();


    }

    private void checkStatusEmployee() {
        if (!employeeService.getEmployees().isEmpty()) {
            for (EmployeeDto employeeDto : employeeService.getEmployees()) {
                if (employeeDto.getDateOfAdmission().equals(LocalDateTime.now())) {
                    Employee employeeById = employeeRepository.findById(employeeDto.getId())
                            .orElseThrow(() -> new EmployeeNotFoundException("Employee not found"));
                    employeeById.setJobStatus(JobStatus.WORKING);
                    employeeService.updateEmployee(employeeById, employeeById.getId());
                }
            }
        }
    }

}

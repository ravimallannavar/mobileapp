import { Component, OnInit } from '@angular/core';
import { EmpDetailsService } from '../_Service/EmpDetails/emp-details.service';
import { EmpDetails } from '../_Model/EmpDetails/emp-details';
import * as $ from 'jquery';
import { UndefinedvaluesService } from '../_Service/UndefinedValues/undefinedvalues.service';
import { Messages } from '../_Model/Messages/messages';

@Component({
  selector: 'app-emp-details',
  templateUrl: './emp-details.component.html',
  styleUrls: ['./emp-details.component.scss'],
})
export class EmpDetailsComponent implements OnInit {
  employeename: string;
  employeesignature: string;
  employeedate: Date;
  employeeremark: string;

  constructor(private empdetails: EmpDetailsService, private undefinedvalue: UndefinedvaluesService, private empdetailsmodel: EmpDetails) { }

  ngOnInit() {
    $(document).ready(function () {
      $("#empdate").val(new Date());
    });

    // this.router.paramMap.subscribe(params => {
    //   this.LoginId = params.get("LoginId");
    // })
  }

  InsertEmpDetails() {
    this.employeedate = new Date();

    this.empdetailsmodel.LoginId_ = Number(localStorage.getItem('LoginId'));
    this.empdetailsmodel.EmpName_ = this.employeename;
    this.empdetailsmodel.EmpSignature_ = this.employeesignature;
    this.empdetailsmodel.EmpDate_ = this.employeedate;
    this.empdetailsmodel.EmpRemark_ = this.employeeremark;
    
    this.empdetailsmodel.EmpSignature_ = this.undefinedvalue.GetValue(this.empdetailsmodel.EmpSignature_);
    this.empdetailsmodel.EmpRemark_ = this.undefinedvalue.GetValue(this.empdetailsmodel.EmpRemark_);

    this.empdetails.InsertEmpDetails(this.empdetailsmodel).subscribe(Response => {
      
    }, error => {
      alert(JSON.stringify(error));
    }, () => {
      alert(Messages.InsertEmpDetails);
    });
  }
}
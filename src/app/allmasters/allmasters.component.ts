import { Component, OnInit, DoCheck } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { MasterService } from '../_Service/Master/master.service';
import * as $ from 'jquery';

@Component({
  selector: 'app-allmasters',
  templateUrl: './allmasters.component.html',
  styleUrls: ['./allmasters.component.scss'],
})
export class AllmastersComponent implements OnInit, DoCheck {
  public crud: string;
  MasterId: string;
  AllMasterDetails = [];
  AllMasterDetailsWithValue = [];
  allmasters: string;

  ngDoCheck(): void {
    this.route.queryParams.subscribe(params => {
      this.crud = params['crud'];
    });
  }

  constructor(private route: ActivatedRoute, private allmasterservice: MasterService) { }

  ngOnInit() {
   this.allmasterservice.GetAllMastersName().subscribe(Response => {
     this.AllMasterDetails = JSON.parse(JSON.stringify(Response));
   });

   this.show(1, 1);
   this.hidediv(1);
  }

  show(id, hidtitle) {
    $("#edit_" + id).click(function(){
      $("#txt_" + id).val(hidtitle);
      $("#lbl_" + id).css('display', 'none');
      $("#edit_" + id).css('display', 'none');
      $("#update_" + id).css('display', 'block');
      $("#cancel_" + id).css('display', 'block');
      $("#txt_" + id).css('display', 'block');
    });
  }

  hidediv(id) {
    $("#cancel_" + id).click(function(){
      $("#lbl_" + id).css('display', 'block');
      $("#edit_" + id).css('display', 'block');
      $("#update_" + id).css('display', 'none');
      $("#cancel_" + id).css('display', 'none');
      $("#txt_" + id).css('display', 'none');
    });
  }
  GetId(event) {
    this.MasterId = event.target.value;

    this.allmasterservice.GetAllMastersDetailsUsingName(event.target.value).subscribe(Response => {
      this.AllMasterDetailsWithValue = JSON.parse(JSON.stringify(Response));
    });
  }
}

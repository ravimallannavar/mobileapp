import { Component, OnInit } from '@angular/core';
// import { MakemasterService } from '../Service/_MakeMaster/makemaster.service';
import { Makemaster } from '../_Model/_MakeMaster/makemaster';
import { MakemasterService } from '../_Service/MakeMaster/makemaster.service';

@Component({
  selector: 'app-makemaster',
  templateUrl: './makemaster.component.html',
  styleUrls: ['./makemaster.component.scss'],
})
export class MakemasterComponent implements OnInit {
  Modelnm:string;
  Modelno:string;
  MakeId_:Number;
  constructor(private makemasterservice:MakemasterService,private makemastermodel:Makemaster) { }


  ngOnInit() {}
  
  InsertMakeMaster()
  {
    this.makemasterservice.InsertMakeMaster(this.makemastermodel).subscribe(Response=>{
      console.log(Response);
    })
  }
  UpdateMakeMaster()
  {
    this.makemasterservice.UpdateMakeMaster(this.makemastermodel).subscribe(Response=>{
      console.log(Response);
    })
  }
  DeleteMakeMaster()
  {
    this.makemasterservice.DeleteMakeMaster(this.MakeId_).subscribe(Response=>{
      console.log(Response);
    })
  }

}

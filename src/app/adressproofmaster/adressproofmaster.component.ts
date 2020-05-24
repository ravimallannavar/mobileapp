import { Component, OnInit, DoCheck } from '@angular/core';
import { AdressproofmasterService } from '../_Service/AddressProofMaster/adressproofmaster.service';
import { Addressproofmaster } from '../_Model/AddressProofMaster/addressproofmaster';
import { AllmastersComponent } from '../allmasters/allmasters.component';

@Component({
  selector: 'app-adressproofmaster',
  templateUrl: './adressproofmaster.component.html',
  styleUrls: ['./adressproofmaster.component.scss'],
})

export class AdressproofmasterComponent implements OnInit, DoCheck {
  AddressProofId_:number;
  Title:string;
  
  ngDoCheck() {
    return this.masters.crud;
  }
  
  constructor(private addressproofmaster:AdressproofmasterService,
    private addressproofmastermodel:Addressproofmaster, private masters: AllmastersComponent) { }

  ngOnInit() {
    
  }
  UpdateAddressProofMaster()
  {
    this.addressproofmaster.UpdateAddressProofMaster(this.addressproofmastermodel).subscribe(Response=>{
      console.log(Response);
    })
    
  }
  InsertAddressProofMaster()
  {
    this.addressproofmaster.InsertAddressProofMaster(this.addressproofmastermodel).subscribe(Response=>{
      console.log(Response);
    })

}
DeleteAddressProofMaster()
{
  this.addressproofmaster.DeleteAddressProofMaster(this.AddressProofId_).subscribe(Response=>{
    console.log(Response);
  })

}
}





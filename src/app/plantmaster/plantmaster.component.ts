import { Component, OnInit } from '@angular/core';
import { Plantmaster } from '../_Model/_PlantMaster/plantmaster';
import { PlantmasterService } from '../_Service/PlantMaster/plantmaster.service';

@Component({
  selector: 'app-plantmaster',
  templateUrl: './plantmaster.component.html',
  styleUrls: ['./plantmaster.component.scss'],
})
export class PlantmasterComponent implements OnInit {
  PlantId_:number;
  PlantNm: string;
  
  constructor(private plantService: PlantmasterService) { }

  ngOnInit() {}

  InsertPlantMaster(PlantmasterModel: Plantmaster)
  {
    return this.plantService.InsertPlantMaster(PlantmasterModel).subscribe(Response => {

    });
  }

  UpdatePlantMaster(PlantmasterModel:Plantmaster)
  {
    return this.plantService.UpdatePlantMaster(PlantmasterModel).subscribe(Response => {
      
    });
  }
  DeletePlantMaster()
  {
    return this.plantService.DeletePlantMaster(this.PlantId_).subscribe(Response => {
      
    });
  }
}

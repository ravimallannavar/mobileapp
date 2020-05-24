import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Plantmaster } from 'src/app/_Model/_PlantMaster/plantmaster';
import { Url } from 'src/app/_Model/url';
import { WebApiPages } from 'src/app/_Model/web-api-pages';

@Injectable({
  providedIn: 'root'
})
export class PlantmasterService {

  constructor(private http:HttpClient) { }

  InsertPlantMaster(PlantmasterModel:Plantmaster)
  {
    return this.http.post(Url.WebApiUrl + WebApiPages.InsertMakeMaster, PlantmasterModel);
  }
  UpdatePlantMaster(PlantmasterModel:Plantmaster)
  {
    return this.http.patch(Url.WebApiUrl + WebApiPages.UpdateMakeMaster, PlantmasterModel);

  }
  DeletePlantMaster(PlantId_)
{
    return this.http.delete(Url.WebApiUrl + WebApiPages.DeleteMakeMaster+PlantId_);

  }
 }

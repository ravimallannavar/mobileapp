import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';

import { Url } from 'src/app/_Model/url';
import { WebApiPages } from 'src/app/_Model/web-api-pages';

import { Addressproofmaster } from 'src/app/_Model/AddressProofMaster/addressproofmaster';

@Injectable({
  providedIn: 'root'
})
export class AdressproofmasterService {
  

    constructor(private http: HttpClient) { }
    UpdateAddressProofMaster(addressproofmaster:Addressproofmaster) {
      return this.http.patch(Url.WebApiUrl + WebApiPages.UpdateAddressProofMaster, addressproofmaster);
    }
    InsertAddressProofMaster(addressproofmaster:Addressproofmaster) {
      return this.http.post(Url.WebApiUrl + WebApiPages.InsertAddressProofMaster, addressproofmaster);
    }
    DeleteAddressProofMaster(AddressProofId_) {
      return this.http.delete(Url.WebApiUrl + WebApiPages.DeleteAddressProofMaster +AddressProofId_);
    }
  }
  
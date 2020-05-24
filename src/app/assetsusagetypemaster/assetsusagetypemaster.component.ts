import { Component, OnInit } from '@angular/core';
import { AssetsusagetypemasterService } from '../_Service/AssetUsageTypeMaster/assetsusagetypemaster.service';
import { Assetusagetypemaster } from '../_Model/AssetUsageTypeMaster/assetusagetypemaster';

@Component({
  selector: 'app-assetsusagetypemaster',
  templateUrl: './assetsusagetypemaster.component.html',
  styleUrls: ['./assetsusagetypemaster.component.scss'],
})

export class AssetsusagetypemasterComponent implements OnInit {
  AssetsUsageTypeMasterId_: number;
  title: string;
  constructor(private assetusagetypemaster: AssetsusagetypemasterService, private assetusagetypemastermodel: Assetusagetypemaster) { }

  ngOnInit() { }
  UpdateAssetUsageTypeMaster() {
    return this.assetusagetypemaster.UpdateAssetUsageTypeMaster(this.assetusagetypemastermodel).subscribe(Response => {

    });

  }
  InsertAssetUsageTypeMaster() {
    // AssetsUsageTypeMasterId_:number;
    // Title_:string;
  //  this.assetusagetypemaster.Title_ = this.title;
    return this.assetusagetypemaster.InsertAssetUsageTypeMaster(this.assetusagetypemastermodel).subscribe(Response => {

    });


  }
  DeleteAssetUsageTypeMaster() {
    return this.assetusagetypemaster.DeleteAssetUsageTypeMaster(this.AssetsUsageTypeMasterId_).subscribe(Response => {

    });


  }
}



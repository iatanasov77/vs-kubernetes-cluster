import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http'
import { Observable } from "rxjs";
import { IDevOpsConfig } from "./devops-config.interface";

const backendURL = 'http://api.kube-controller.lh/angular-api.php';

@Injectable({
    providedIn: 'root'
})
export class ApiService
{
    constructor( private httpClient: HttpClient ) { }
    
    loadDevOpsConfigJson()
    {
        return this.httpClient.get<IDevOpsConfig>( backendURL );
    }
}

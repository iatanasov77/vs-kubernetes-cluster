import { Component, OnInit, Input } from '@angular/core';

import { IDevOpsConfig } from "../../../services/devops-config.interface";

@Component({
    selector: 'app-page-examples-kubernetes',
    templateUrl: './examples-kubernetes.component.html',
    styleUrls: []
})
export class ExamplesKubernetesComponent implements OnInit
{
    @Input() devopsConfig?: IDevOpsConfig;
    
    constructor()
    {
        
    }
    
    ngOnInit()
    {
        //console.log( this.devopsConfig$ );
    }
}

import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { AppRoutingModule } from '../app-routing.module';
import { SharedModule } from '../shared/shared.module';

import { HomeComponent } from './home/home.component';
import { ExamplesContainerComponent } from './examples/container/examples-container.component';
import { ExamplesKubernetesComponent } from './examples/kubernetes/examples-kubernetes.component';
import { ExamplesAnsibleComponent } from './examples/ansible/examples-ansible.component';
import { ExamplesHashicorpComponent } from './examples/hashicorp/examples-hashicorp.component';
import { ExamplesOtherComponent } from './examples/other/examples-other.component';

import { ExternalToolsComponent } from './external-tools/external-tools.component';
import { DevopsServicesComponent } from './devops-services/devops-services.component';

@NgModule({
    declarations: [
        HomeComponent,
        ExamplesKubernetesComponent,
        ExamplesContainerComponent,
        ExamplesAnsibleComponent,
        ExamplesHashicorpComponent,
        ExamplesOtherComponent,
        
        ExternalToolsComponent,
        DevopsServicesComponent
    ],
    imports: [
        CommonModule,
        AppRoutingModule,
        SharedModule
    ],
    exports: [
        HomeComponent,
        ExamplesKubernetesComponent,
        ExamplesContainerComponent,
        ExternalToolsComponent,
        DevopsServicesComponent
    ]
})
export class PagesModule { }

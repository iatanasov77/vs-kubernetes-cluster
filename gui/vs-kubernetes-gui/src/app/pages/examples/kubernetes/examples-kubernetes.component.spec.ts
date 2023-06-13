import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ExamplesKubernetesComponent } from './examples-kubernetes.component';

describe('ExamplesKubernetesComponent', () => {
  let component: ExamplesKubernetesComponent;
  let fixture: ComponentFixture<ExamplesKubernetesComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ExamplesKubernetesComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ExamplesKubernetesComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

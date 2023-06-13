import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ExternalToolsComponent } from './external-tools.component';

describe('ExternalToolsComponent', () => {
  let component: ExternalToolsComponent;
  let fixture: ComponentFixture<ExternalToolsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ExternalToolsComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ExternalToolsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

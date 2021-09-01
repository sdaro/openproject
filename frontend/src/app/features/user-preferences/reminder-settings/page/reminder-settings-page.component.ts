import {
  ChangeDetectionStrategy, Component, Input, OnInit,
} from '@angular/core';
import { I18nService } from 'core-app/core/i18n/i18n.service';
import { CurrentUserService } from 'core-app/core/current-user/current-user.service';
import { take } from 'rxjs/internal/operators/take';
import { UIRouterGlobals } from '@uirouter/core';
import { UserPreferencesService } from 'core-app/features/user-preferences/state/user-preferences.service';
import { UserPreferencesQuery } from 'core-app/features/user-preferences/state/user-preferences.query';

export const myReminderPageComponentSelector = 'op-reminders-page';

@Component({
  selector: myReminderPageComponentSelector,
  templateUrl: './reminder-settings-page.component.html',
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class ReminderSettingsPageComponent implements OnInit {
  @Input() userId:string;

  text = {
    title: this.I18n.t('js.reminders.settings.title'),
    save: this.I18n.t('js.button_save'),
    daily: {
      title: this.I18n.t('js.reminders.settings.daily.title'),
      explanation: this.I18n.t('js.reminders.settings.daily.explanation'),
    },
  };

  constructor(
    private I18n:I18nService,
    private stateService:UserPreferencesService,
    private query:UserPreferencesQuery,
    private currentUserService:CurrentUserService,
    private uiRouterGlobals:UIRouterGlobals,
  ) {
  }

  ngOnInit():void {
    this
      .currentUserService
      .user$
      .pipe(take(1))
      .subscribe((user) => {
        this.userId = (this.userId || this.uiRouterGlobals.params.userId) as string || user.id!;
        this.stateService.get(this.userId);
      });
  }

  public saveChanges():void {
    const prefs = this.query.getValue();
    this.stateService.update(this.userId, prefs);
  }
}

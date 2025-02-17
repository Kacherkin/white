// Работа с церебралами

/obj/item/book/granter/action/spell/psychotherapy
	granted_action = /datum/action/cooldown/spell/pointed/psychotherapy
	action_name = "основы психологической помощи"
	icon_state = "bookblind"
	desc = "Книга описывающая азы психотерапии."
	pages_to_mastery = 1
	remarks = list(
		"Люди устроены очень сложно!",
	)

/datum/action/cooldown/spell/pointed/psychotherapy
	name = "Сеанс психотерапии"
	desc = "Позволяет провести сеанс психотерапии с пациентом, страдающим от церебральных травм. Время сеанса варьируется в зависимости от того, проходит ли тот в кабинете психолога и принял ли пациент седативные препараты."
	button_icon_state = "mindswap"
	ranged_mousepointer = 'icons/effects/mouse_pointers/mindswap_target.dmi'

//	sound = 'sound/magic/blind.ogg'
	school = SCHOOL_UNSET
	cooldown_time = 5 SECONDS
	cast_range = 4

	invocation_type = INVOCATION_NONE
	spell_requirements = NONE

	active_msg = "Пора начинать сеанс психотерапии..."
	deactive_msg = "Сейчас не время..."

	var/psychotherapy_cd = 60 SECONDS
	var/cast_time = 36
	var/cast_process = FALSE
	var/list/valid_areas = list(/area/medical/psychology, /area/service/chapel, /area/security/main/sb_med, /area/service/theater)

	var/dialog_user = list(
		"О чем вы хотите поговорить?",
		"Все что вы расскажете, останется в этом кабинете.",
		"Понимаю, вам тяжело говорить об этом.",
		"Это неприятно. Давайте попробуем понять, в чем дело.",
		"Поделитесь тем, что беспокоит прямо сейчас.",
		"Расскажите, пожалуйста, что привело вас ко мне",
		"Вы уже предпринимали что-то для решения ситуации? Если да, то что именно?",
		"Понял вас.",
		"Главное помните - вы не одни!",
		"Вы всегда можете расчитывать на подставленное плечо.",
		"Сбросьте тот груз, что отягощает ваши плечи.",
		"Освободите себя от призраков прошлого.",
		"Жизнь на этом не заканчивается. У вас все еще впереди.",
		"То что нас не убивает, делает нас сильнее.",
		"Я всецело на Вашей стороне.",
		"Закройте глаза. Вдохните глубоко. Почувствуйте кончики своих пальцев…",
		"Давайте рассмотрим ситуацию со стороны.",
		"Не бывает неправильных решений. Вы поступили так, как чувствовали в тот момент.",
		"Я понимаю что Вы чувствуете.",
		"Всё будет хорошо!",
		"Вам следует сфокусироваться на своей работе - и проблемы как рукой снимет.",
		"Вам следует переключиться на другое занятие.",
		"Вам следует отвлечься от проблем.",
		"Вы ни в чём не виноваты, это могло случиться с каждым.",
		"Вам явно нужна помощь. И вы ее получите!",
		"Все образуется.",
		"Вы всегда, я ещё раз повторяю - всегда! Можете положиться на меня.",
		"Здесь вы в безопасности.",
		"Расслабьтесь...",
		"Закройте глаза... Загляните в своё подсознание...",
		"Зачастую наши проблемы тянутся из детства. Возможно это детская травма?",
		"Вы принимаете это слишком близко к сердцу! Не переживате об этом!",
		"Корень вашей проблемы, сокрыт в ваших мыслях.",
		"Вспомните что-нибудь приятное из детства.",
		"Представьте бескрайний луг... Присядьте... Потрогайте траву...",
		"Вы любите котиков?",
		"У каждого в жизни бывают трудные моменты... Это нормально.",
		"Ощутите спокойствие...",
		"Вы пробовали заниматься Йогой?",
		"Попробуйте подойти к илюминатору... Ваши проблемы растворяться в глубине космоса...",
		"Вы любите смотреть на звезды?",
		"Покажите на этой анатомической кукле где вас трогали?",
		"М-м-пнятненько...",
		"Вам не стоит зацикливаться на этом, вы не одиноки в этой проблеме.",
		"Если вы думаете что сейчас вам плохо, то вспомните свое собеседование!",
		"Не волнуйтесь! Вашим родственникам будет выплачена компенсация!",
		"И тебя вылечат...",
		"Чисто анатомически жопа - вовсе не безвыходная ситуация...",
		"Вы выпили свои таблетки?",
		"Зато не в дурдоме...",
		"Если вы чувствуете боль - вы все еще живы.",
	)

	var/dialog_target = list(
		"Даже не знаю, с чего начать...",
		"Я плохо сплю. Что-то тревожит меня, но я не понимаю, что...",
		"Эта станция... Она ужасна... Мне кажется мы все умрем здесь...",
		"Иногда мне кажется, что все вокруг не настоящее... Это как будто какая-то симуляция...",
		"Каждый раз когда я смотрю в открытый космос, мне кажется что-кто-то смотрит на меня в ответ...",
		"У меня такое ощущение что я попал в петлю, что все вокруг повторяется...",
		"Когда я смотрю на себя в зеркало, я нахожу все новые и новые шрамы... Но я не помню когда я их получил...",
		"Иногда мне кажется что я был кем-то другим, с иным цветом кожи, прической, полом и даже именем... А иногда даже и не человеком...",
		"Иногда мне кажется, что убить человека... это же не так страшно? Что в этом такого? Это не правильно, но я не чувствую отторжения при этой мысли..",
		"Я помню как я умирал... я помню эту боль... как я задыхался... как мне вскрывали грудь лазерным мечем... как меня расстреливали из лазеров...",
		"Иногда меня охватывает неконтролируемая ярость, я готов убить по самому надуманному поводу... за обычный толчок или глупую фразу...",
		"Когда я берусь за какую-либо работу, я иногда просто не понимаю откуда я все это знаю? Я же никогда в своей жизни этим не занимался!",
		"Я ощущаю себя марионеткой.",
		"Иногда я теряю счет времени... я даже не знаю какой сегодня день недели...",
		"Как только я ступил на эту станцию, я осознал, что тут есть кто-то кто замыслил что-то чудовищное против меня или окружающих...",
		"Клоун пугает меня... мне часто кажется, что под этой улыбчивой маской находится чудовищное кожистое лицо... а может эта маска и есть его лицо?",
		"Почему этот черно-белый человек в подтяжках постоянно смотрит на меня? Он не двигается, не говорит, он просто смотрит прямо в душу...",
		"Мне кажется что я никому не могу доверять, мне постоянно кажется, что все они могут предать меня...",
		"За что мне все это? Я просто искал работу...",
		"Иногда я просто бесцельно начинаю слоняться по станции...",
		"Иногда я замечаю за собой желание, найти какое-нибудь оружие... Словно скоро произойдет что-то ужасное...",
		"Меня кто-то преследует... и явно не с добрыми намерияниями",
		"Я иногда не узнаю себя в отражении зеркала...",
		"Я ощущаю себя бездушным механизмом в какой-то странной системе...",
		"Меня посещают странные мысли, настолько чужеродные, что они пугают меня самого...",
		"У меня непрекращающееся чувство дежавю...",
		"Я сегодня не такой как вчера...",
		"Я иногда забываю как меня зовут...",
		"Мне очень трудно вспоминать события из моей жизни, предшествующие тому, как я попал на эту станцию...",
		"Иногда мне кажется что за пределами этой станции ничего не существует...",
		"В определенные случайные моменты, я могу просто потерять интерес ко всему происходящему... просто лечь прямо на пол... и уснуть...",
		"Как только эвакуационный шаттл пристыкуется к ЦК... я кого-то точно убью...",
		"Мне кажется как только мы прибудем на ЦК все это закончится...",
		"Я заметил, что я совершенно не ценю свою жизнь, я готов иногда умереть просто ради шутки...",
		"Оскорбления стали для меня болезненнее, чем физические травмы...",
		"Я чувствую себя куклой в руках ребенка...",
		"Кто такой Валера?!",
		"Я иногда путаюсь в своих руках...",
		"Хоть меня и ужасают все эти раны, на самом деле я совершенно не чувствую боли...",
		"У меня есть мечта... далекая... светлая... белая мечта...",
		"Все вокруг меня фальшивое... как это вообще может работать?",
		"Все вокруг какое-то плоское...",
		"Этот мир состоит из квадратов... и точек...",
		"Я не слышу голоса... я их вижу...",
		"У меня такое ощущение, что тут нет потолка...",
		"Я не верю всем, кто работает или просто ходит рядом со мной, даже если я знаю, что он благожелателен ко мне и не причинит зла. Что со мной? ",
		"Иногда я не понимаю окружающих людей... они говорят непонятные вещи...",
		"Я не верю вашим словам.",
		"Я хочу ощутить под ногами реальную землю... Я хочу вдохнуть настоящий нефильтрованный воздух...",
		"Вокруг вроде как много людей... и они меня даже не избегают... но я все равно чувствую себя очень одиноким...",
		"Я постоянно чувствую себя виноватым во всем негативном что происходит вокруг меня... даже если я был прав или вообще был жертвой...",
	)

/datum/action/cooldown/spell/pointed/psychotherapy/is_valid_target(atom/cast_on)
	if(cast_on == owner)
		to_chat(owner, span_warning("Разговаривать с самим собой... это не выход..."))
		return FALSE

	if(get_dist(owner, cast_on) > cast_range)
		to_chat(owner, span_warning("[cast_on.p_theyre(TRUE)] слишком далеко!"))
		return FALSE

	if(!isliving(cast_on))
		to_chat(owner, span_warning("Обычно только мои пациенты общаются с неодушевленными предметами, не буду опускаться до их уровня!"))
		return FALSE

	if(istype(cast_on, /mob/living/carbon/human))
		var/mob/living/carbon/human/target = cast_on
		if(target.psychotherapy_last_time + psychotherapy_cd > world.time)
			to_chat(owner, span_warning("Этому пациенту необходим отдых! Лучше не начинать с ним новую сессию раньше чем через [(target.psychotherapy_last_time + psychotherapy_cd - world.time)/10] секунд. Ну или можно поразговаривать с ним на отвлеченные темы."))
			return FALSE
	else
		to_chat(owner, span_warning("Я не очень понимаю как вести диалог с... таким... пациентом..."))
		return FALSE

	var/mob/living/living_target = cast_on
	if(living_target.stat == DEAD)
		to_chat(owner, span_warning("Я не медиум и не способен общаться с мертвыми!"))
		return FALSE
	if(!living_target.mind)
		to_chat(owner, span_warning("Разум этого бедолаги окончательно покинул его сознание, ему уже не помочь!"))
		return FALSE
	if(!living_target.key)
		to_chat(owner, span_warning("Этот пациент впал в кому, ему уже не помочь!"))
		return FALSE

	return TRUE


//	Начало сеанса
/datum/action/cooldown/spell/pointed/psychotherapy/proc/on_cast_start(mob/living/carbon/human/cast_on)
	cast_time = initial(cast_time)
	if(is_type_in_list(get_area(owner), valid_areas))
		cast_time = cast_time / 2

	if(cast_on.reagents.has_reagent(/datum/reagent/medicine/neurine) || cast_on.reagents.has_reagent(/datum/reagent/pax) || cast_on.reagents.has_reagent(/datum/reagent/medicine/mannitol) || cast_on.reagents.has_reagent(/datum/reagent/medicine/psicodine) || cast_on.reagents.has_reagent(/datum/reagent/drug/happiness))
		if(cast_time == cast_time / 2)
			cast_time = cast_time / 3
		else
			cast_time = cast_time / 2



	to_chat(cast_on, span_notice("Сеанс психотерапии начался, мне лучше расслабиться и постараться не двигаться..."))
	to_chat(owner, span_notice("Что же, начнем!"))
	owner.say("Не желаете ли поговорить об вашем психическом здоровье?", forced=name)


//	Преждевременное прерывание сеанса
/datum/action/cooldown/spell/pointed/psychotherapy/proc/on_cast_stopped(mob/living/carbon/human/cast_on)
	to_chat(cast_on, span_notice("Мне не очень комфортно говорить сейчас..."))
	to_chat(owner, span_notice("Сейчас не лучшее время для психотерапии..."))

//	Удачное завершение сеанса
/datum/action/cooldown/spell/pointed/psychotherapy/proc/on_cast_finished(mob/living/carbon/human/cast_on)
	to_chat(cast_on, span_notice("Кажется мне стало лучше!"))
	to_chat(owner, span_notice("Мне удалось облегчить душевные терзания этого бедолаги..."))
	owner.say("Давайте закончим на этом на сегодня.", forced=name)

	var/obj/item/organ/brain/B = cast_on.getorganslot(ORGAN_SLOT_BRAIN)

	for(var/i in B.traumas)
		var/datum/brain_trauma/trauma = i

		switch(trauma.resilience)
			if(TRAUMA_RESILIENCE_BASIC)
				cast_on.cure_all_traumas(TRAUMA_RESILIENCE_BASIC)
			if(TRAUMA_RESILIENCE_WOUND)
				cast_on.cure_all_traumas(TRAUMA_RESILIENCE_WOUND)
			if(TRAUMA_RESILIENCE_SURGERY)
				trauma.resilience = TRAUMA_RESILIENCE_BASIC
			if(TRAUMA_RESILIENCE_LOBOTOMY)
				trauma.resilience = TRAUMA_RESILIENCE_SURGERY
	if(cast_on.mind?.has_antag_datum(/datum/antagonist/brainwashed))
		cast_on.mind.remove_antag_datum(/datum/antagonist/brainwashed)
	if(cast_on.mind?.has_antag_datum(/datum/antagonist/abductee))
		cast_on.mind.remove_antag_datum(/datum/antagonist/abductee)
	cast_on.psih_hud_set_status()
	cast_on.psychotherapy_last_time = world.time

//	Процесс сеанса с диалогом
/datum/action/cooldown/spell/pointed/psychotherapy/proc/dialog(mob/living/carbon/human/cast_on)
	if(prob(50))
		if(!do_after(owner, 5 SECONDS, owner))
			return FALSE
		owner.say("[pick(dialog_user)]", forced=name)
	else
		if(!do_after(cast_on, 5 SECONDS, cast_on))
			return FALSE
		cast_on.say("[pick(dialog_target)]", forced=name)
	return TRUE

//	Контролер каста
/datum/action/cooldown/spell/pointed/psychotherapy/cast(mob/living/carbon/human/cast_on)
	. = ..()
	if(cast_process)
		to_chat(owner, span_warning("Не сейчас!"))
		return FALSE

	on_cast_start(cast_on)
	cast_process = TRUE
	for(var/i in 1 to cast_time)
		if(!dialog(cast_on))
			on_cast_stopped()
			cast_process = FALSE
			return
	on_cast_finished(cast_on)
	cast_process = FALSE

	return TRUE

//  Оверлей Церебрала

/obj/item/organ/cyberimp/eyes/hud/psih
	name = "имплант интерфейса психолога"
	desc = "Эти кибернетический чип выводит медицинский интерфейс поверх всего что вы видите, так так же распознает микромимику."
	HUD_type = DATA_HUD_PSIH
	HUD_trait = TRAIT_MEDICAL_HUD

--created by NovaTsukimori, coded by Lyris
--RUM－ライリス・フォース
function c240100045.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c240100045.target)
	e1:SetOperation(c240100045.activate)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_CUSTOM+240100045)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,240100045+EFFECT_COUNT_CODE_DUEL)
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetTarget(c240100045.thtg)
	e2:SetOperation(c240100045.thop)
	c:RegisterEffect(e2)
end
function c240100045.filter1(c,e,tp)
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
		and Duel.IsExistingMatchingCard(c240100045.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,c,rk+1,c:GetRace())
		and Duel.GetLocationCountFromEx(tp,tp,c)>0
end
function c240100045.filter2(c,e,tp,mc,rk,rc)
	return c:GetRank()==rk and c:IsSetCard(0x7c4) and c:GetRace()==rc and mc:IsCanBeXyzMaterial(c)
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false)
end
function c240100045.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c240100045.filter1(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c240100045.filter1,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c240100045.filter1,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c240100045.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if Duel.GetLocationCountFromEx(tp,tp,tc)<=0 then return end
	if tc:IsFacedown() or not tc:IsRelateToEffect(e) or tc:IsControler(1-tp) or tc:IsImmuneToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c240100045.filter2,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,tc,tc:GetRank()+1,tc:GetRace())
	local sc=g:GetFirst()
	if sc then
		local mg=tc:GetOverlayGroup()
		if mg:GetCount()~=0 then
			Duel.Overlay(sc,mg)
		end
		sc:SetMaterial(Group.FromCards(tc))
		Duel.Overlay(sc,Group.FromCards(tc))
		if Duel.SpecialSummon(sc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)~=0 then
			sc:CompleteProcedure()
			local de=Effect.CreateEffect(e:GetHandler())
			de:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
			de:SetCode(EVENT_TO_GRAVE)
			de:SetCondition(c240100045.descon)
			de:SetOperation(c240100045.desop)
			de:SetReset(RESET_EVENT+0x1fe0000)
			sc:RegisterEffect(de)
		end
	end
end
function c240100045.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_DESTROY)
end
function c240100045.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.RaiseEvent(e:GetHandler(),EVENT_CUSTOM+240100045,e,0,0,0,0)
end
function c240100045.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToHand() end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function c240100045.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SendtoHand(c,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,c)
	end
end

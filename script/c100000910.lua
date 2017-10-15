 --Created and coded by Rising Phoenix
function c100000910.initial_effect(c)
	Duel.EnableGlobalFlag(GLOBALFLAG_DECK_REVERSE_CHECK)
		--cannot release
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UNRELEASABLE_SUM)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UNRELEASABLE_NONSUM)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetCode(EFFECT_CANNOT_BE_FUSION_MATERIAL)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	c:RegisterEffect(e4)
	local e5=e3:Clone()
	e5:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	c:RegisterEffect(e5)
	--to deck
	local e6=Effect.CreateEffect(c)
	e6:SetCategory(CATEGORY_TODECK)
	e6:SetType(EFFECT_TYPE_IGNITION)
	e6:SetRange(LOCATION_GRAVE)
	e6:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e6:SetTarget(c100000910.target)
	e6:SetOperation(c100000910.operation)
	c:RegisterEffect(e6)
	--atk
		local e7=Effect.CreateEffect(c)
	e7:SetCategory(CATEGORY_ATKCHANGE)
	e7:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e7:SetRange(LOCATION_MZONE)
	e7:SetCode(EVENT_SPSUMMON_SUCCESS)
	e7:SetCondition(c100000910.condition2)
	e7:SetTarget(c100000910.target2)
	e7:SetOperation(c100000910.operation2)
	c:RegisterEffect(e7)
	local e8=Effect.CreateEffect(c)
	e8:SetCategory(CATEGORY_ATKCHANGE)
	e8:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e8:SetRange(LOCATION_MZONE)
	e8:SetCode(EVENT_SUMMON_SUCCESS)
	e8:SetCondition(c100000910.condition2)
	e8:SetTarget(c100000910.target2)
	e8:SetOperation(c100000910.operation2)
	c:RegisterEffect(e8)
		local e9=Effect.CreateEffect(c)
	e9:SetCategory(CATEGORY_ATKCHANGE)
	e9:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e9:SetRange(LOCATION_MZONE)
	e9:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	e9:SetCondition(c100000910.condition2)
	e9:SetTarget(c100000910.target2)
	e9:SetOperation(c100000910.operation2)
	c:RegisterEffect(e9)
		--special summon
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_FIELD)
	e10:SetCode(EFFECT_SPSUMMON_PROC)
	e10:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e10:SetRange(LOCATION_HAND)
	e10:SetCondition(c100000910.spconm)
	c:RegisterEffect(e10)
	--eff
		local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD)
	e12:SetCode(EFFECT_DISABLE)
	e12:SetRange(LOCATION_MZONE)
	e12:SetTargetRange(LOCATION_MZONE,0)
	e12:SetTarget(c100000910.targetx)
	c:RegisterEffect(e12)
		local e14=e12:Clone()
	e14:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	c:RegisterEffect(e14)
		local e15=e12:Clone()
	e15:SetCode(EFFECT_CANNOT_TRIGGER)
	c:RegisterEffect(e15)
		local e16=e12:Clone()
	e16:SetCode(EFFECT_CANNOT_ACTIVATE)
	c:RegisterEffect(e16)
		--atkdownslifer
		local e17=Effect.CreateEffect(c)
	e17:SetDescription(aux.Stringid(100000910,0))
e17:SetCategory(CATEGORY_ATKCHANGE)
	e17:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e17:SetType(EFFECT_TYPE_IGNITION)
	e17:SetCountLimit(1)
	e17:SetRange(LOCATION_MZONE)
	e17:SetOperation(c100000910.thophhatk)
	c:RegisterEffect(e17)
		--control
	local e18=Effect.CreateEffect(c)
	e18:SetType(EFFECT_TYPE_SINGLE)
	e18:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e18:SetRange(LOCATION_MZONE)
	e18:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
	c:RegisterEffect(e18)
end
function c100000910.thophhatk(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	e1:SetValue(-750)
	c:RegisterEffect(e1)
			if preatk~=0 and c:GetAttack()==0 then
	Duel.SendtoGrave(c,nil,REASON_EFFECT)
end
end
function c100000910.spfilterm(c)
	return c:IsFaceup() and c:IsSetCard(0x111) and c:IsType(TYPE_MONSTER)
end
function c100000910.spconm(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c100000910.spfilterm,tp,LOCATION_MZONE,0,1,nil)
end
function c100000910.condition2(e,tp,eg,ep,ev,re,r,rp)
	return not eg:IsContains(e:GetHandler()) and eg:IsExists(c100000910.cfilter,1,nil,tp)
end
function c100000910.cfilter(c,tp)
	return c:IsSetCard(0x111) and c:IsFaceup()
end
function c100000910.target2(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return e:GetHandler():IsRelateToEffect(e) and e:GetHandler():IsFaceup() end
end
function c100000910.operation2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_COPY_INHERIT)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(500)
		c:RegisterEffect(e1)
	end
end
function c100000910.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
end
function c100000910.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.SendtoDeck(c,1-tp,2,REASON_EFFECT)
	if not c:IsLocation(LOCATION_DECK) then return end
	Duel.ShuffleDeck(1-tp)
	c:ReverseInDeck()
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_HAND)
	e1:SetCondition(c100000910.spcon)
	e1:SetTarget(c100000910.sptg)
	e1:SetOperation(c100000910.spop)
	e1:SetReset(RESET_EVENT+0x1de0000)
	c:RegisterEffect(e1)
end
function c100000910.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_DRAW)
end
function c100000910.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsRelateToEffect(e) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c100000910.targetx(e,c)
	return c:GetSummonLocation()==LOCATION_HAND and not c:IsSetCard(0x111)
end
function c100000910.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then end
		if Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP_DEFENSE)>0 then end
end
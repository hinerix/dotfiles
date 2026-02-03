import { BaseConfig, ConfigArguments } from "jsr:@shougo/ddc-vim/config";

export class Config extends BaseConfig {
	override config(args: ConfigArguments): Promise<void> {

		const sources = [
      "skkeleton",
      "skkeleton_okuri",
		];

		args.contextBuilder.patchGlobal({
			ui: "native",
			autoCompleteEvents: [
				"InsertEnter",
				"TextChangedI",
				"TextChangedP",
				"TextChangedT",
			],
			sources: sources,
			sourceOptions: {
				skkeleton: {
					mark: "skk",
					matchers: [],
					sorters: [],
					isVolatile: true,
					minAutoCompleteLength: 2,
				},
				skkeleton_okuri: {
					mark: "skk*",
					matchers: [],
					sorters: [],
					isVolatile: true,
					minAutoCompleteLength: 2,
				},
			},
		});
		return Promise.resolve();
	}
}
